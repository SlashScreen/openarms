#[bind] fn test_api()
#[bind] fn ui(id str, ElementDeclaration) -> bool
#[bind] fn text(id str, TextElementConfig)

type Color = [4]byte

type TextWrapMode enum:
    case Words
    case NewLines
    case None

type TextAlignment enum:
    case Left
    case Center
    case Right

type TextElementConfig:
    userData *void
    textColor Color
    fontID r16
    fontSize r16
    letterSpacing r16 = 0
    lineHeight r16 = 0
    wrapMode TextWrapMode = TextWrapMode.Words
    textAlignment TextAlignment = TextAlignment.Left

type Padding:
    left r16
    right r16
    top r16
    bottom r16

type SizingConstraintsMinMax:
    min f32
    max f32

type SizingConstraints:
    sizeMinMax SizingConstraintsMinMax
    sizePercent f32

type SizingType enum:
    case Fit
    case Grow
    case Percent
    case Fixed

type SizingAxis:
    constraints SizingConstraints
    type SizingType

type Sizing:
    width SizingAxis
    height SizingAxis

type ChildAlignment:
    x LayoutAlignmentX
    y LayoutAlignmentY

type LayoutAlignmentX enum:
    case Left
    case Right
    case Center

type LayoutAlignmentY enum:
    case Top
    case Bottom
    case Center

type LayoutDirection enum:
    case LeftToRight
    case TopToBottom

type LayoutConfig:
    sizing Sizing
    padding Padding
    childGap r16
    childAlignment ChildAlignment
    layoutDirection LayoutDirection

type CornerRadius:
    topLeft f32
    topRight f32
    bottomLeft f32
    bottomRight f32

type AspectRatioElementConfig:
    aspectRatio f32

type ImageElementConfig:
    imageData *void

type FloatingElementConfig:
    offset [2]f32
    expand Dimensions
    parentID r32
    zIndex i16
    attachment FloatingAttachPoints
    pointerCaptureMode PointerCaptureNode
    attachTo FloatingAttachToElement
    clipTo FloatingClipToElement

type CustomElementConfig:
    customData *void

type ClipElementConfig:
    horizontal bool
    vertical bool
    childOffset [2]f32

type BorderWidth:
    left r16
    right r16
    top r16
    bottom r16

type BorderElementConfig:
    color Color
    width BorderWidth

type ElementDeclaration:
    layout LayoutConfig
    backgroundColor Color
    cornerRadius CornerRadius
    aspectRatio AspectRatioElementConfig
    image ImageElementConfig
    floating FloatingElementConfig
    custom CustomElementConfig
    clip ClipElementConfig
    border BorderElementConfig
    userData *void

type Dimensions:
    width f32
    height f32

type FloatingAttachPoints:
    element FloatingAttachPointType
    parent FloatingAttachPointType

type FloatingAttachPointType enum:
    case LeftTop
    case LeftCenter
    case LeftBottom
    case CenterTop
    case CenterCenter
    case CenterBottom
    case RightTop
    case RightCenter
    case RightBottom

type PointerCaptureNode enum:
    case Capture
    case Passthrough

type FloatingAttachToElement enum:
    case None
    case Parent
    case ElementWithId
    case Root

type FloatingClipToElement enum:
    case None
    case AttachedParent

type Vector2 = [2]f32

type Dimensions:
    width f32
    height f32

type Arena:
    nextAllocation usize
    capacity usize
    memory *char

type BoundingBox:
    x f32
    y f32
    width f32
    height f32

type BorderData:
    width u32
    color Color

type ElementId:
    id u32
    offset u32
    baseId u32
    stringId String

type RenderCommandType enum:
    case None
    case Rectangle
    case Border
    case Text
    case Image
    case ScissorStart
    case ScissorEnd
    case Custom

type RectangleElementConfig:
    color Color

type TextRenderData:
    stringContents StringSlice
    textColor Color
    fontId u16
    fontSize u16
    letterSpacing u16
    lineHeight u16

type RectangleRenderData:
    backgroundColor Color
    cornerRadius CornerRadius

type ImageRenderData:
    backgroundColor Color
    cornerRadius CornerRadius
    imageData *void

type CustomRenderData:
    backgroundColor Color
    cornerRadius CornerRadius
    customData *void

type BorderRenderData:
    color Color
    cornerRadius CornerRadius
    width BorderWidth

type RenderCommandData:
    rectangle RectangleRenderData
    text TextRenderData
    image ImageRenderData
    custom CustomRenderData
    border BorderRenderData

type RenderCommand:
    boundingBox BoundingBox
    renderData RenderCommandData
    userData *void
    id u32
    zIndex i16
    commandType RenderCommandType

type ScrollContainerData:
    scrollPosition *Vector2
    scrollContainerDimensions Dimensions
    contentDimensions Dimensions
    config ClipElementConfig
    found bool

type ElementData:
    boundingBox BoundingBox
    found bool

type PointerDataInteractionState enum:
    case PressedThisFrame
    case Pressed
    case ReleasedThisFrame
    case Released

type PointerData:
    position Vector2
    state PointerDataInteractionState

type ClayArray[T Any]:
    capacity i32
    length i32
    internalArray *T

type ErrorType enum:
    case TextMeasurementFunctionNotProvided
    case ArenaCapacityExceeded
    case ElementsCapacityExceeded
    case TextMeasurementCapacityExceeded
    case DuplicateId
    case FloatingContainerParentNotFound
    case PercentageOver1
    case InternalError

type ErrorData:
    errorType ErrorType
    errorText String
    userData *void

type ErrorHandler:
    handler *fn(errorData ErrorData)
    userData *void

type Context:
    pass
