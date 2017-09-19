fileIn (scriptspath+"\\GTAV_Map_Helper\\xml.ms")

fn create_InstanceListItem obj face=(
	local FaceNormal = polyop.getFaceNormal obj face
	local NormalX = (((FaceNormal.x +1)*0.5 * 255) as integer)
	local NormalY = (((FaceNormal.y +1)*0.5 * 255) as integer)
	local Color_x = random 0 255
	local Color_y = random 0 255
	local Color_z = random 0 255
	local Ao = 255
	local Pad_x = 0
	local Pad_y = 0
	local Pad_z = 0
	local world_pos = polyop.getFaceCenter obj face
	local batch_pos = (world_pos - obj.min)/(obj.max-obj.min) * 65535 /*world_pos = ((batch_pos / 65535) * (obj.max-obj.min)) + obj.min*/
	local int_batch_pos_x = batch_pos.x as integer
	local int_batch_pos_y = batch_pos.y as integer
	local int_batch_pos_z = batch_pos.z as integer
	
	local XElement_Item2 = dotNetObject "System.Xml.Linq.XElement" XName_Item
	local XElement_Position = dotNetObject "System.Xml.Linq.XElement" XName_Position
	XElement_Position.SetValue ("\n              " + (int_batch_pos_x as string) + "\n              " + (int_batch_pos_y as string) + "\n              " + (int_batch_pos_z as string) + "\n            ")
	XElement_Item2.Add XElement_Position
	local XElement_NormalX = dotNetObject "System.Xml.Linq.XElement" XName_NormalX
	XElement_NormalX.SetAttributeValue XName_value NormalX
	XElement_Item2.Add XElement_NormalX
	local XElement_NormalY = dotNetObject "System.Xml.Linq.XElement" XName_NormalY
	XElement_NormalY.SetAttributeValue XName_value NormalY
	XElement_Item2.Add XElement_NormalY
	local XElement_Color = dotNetObject "System.Xml.Linq.XElement" XName_Color
	XElement_Color.SetValue ("\n              " + (Color_x as string) + "\n              " + (Color_y as string) + "\n              " + (Color_z as string) + "\n            ")
	XElement_Item2.Add XElement_Color
	local XElement_Ao = dotNetObject "System.Xml.Linq.XElement" XName_Ao
	XElement_Ao.SetAttributeValue XName_value Ao
	XElement_Item2.Add XElement_Ao
	local XElement_Pad = dotNetObject "System.Xml.Linq.XElement" XName_Pad
	XElement_Pad.SetValue ("\n              " + (Pad_x as string) + "\n              " + (Pad_y as string) + "\n              " + (Pad_z as string) + "\n            ")
	XElement_Item2.Add XElement_Pad
	
	return XElement_Item2
)

fn create_GrassInstanceListItem obj=(
	local ScaleRange = [0.6,2.3,0.2]
	local lodDist = 40
	local LodFadeStartDist = 20.0
	local LodInstFadeRange = 0.75
	local OrientToTerrain = 1.0
	
	local XElement_Item = dotNetObject "System.Xml.Linq.XElement" XName_Item 
	local XElement_BatchAABB = dotNetObject "System.Xml.Linq.XElement" XName_BatchAABB
	local XElement_min = dotNetObject "System.Xml.Linq.XElement" XName_min
	XElement_min.SetAttributeValue XName_x obj.min.x
	XElement_min.SetAttributeValue XName_y obj.min.y
	XElement_min.SetAttributeValue XName_z obj.min.z
	XElement_min.SetAttributeValue XName_w 0
	local XElement_max = dotNetObject "System.Xml.Linq.XElement" XName_max
	XElement_max.SetAttributeValue XName_x obj.max.x
	XElement_max.SetAttributeValue XName_y obj.max.y
	XElement_max.SetAttributeValue XName_z obj.max.z
	XElement_max.SetAttributeValue XName_w 0
	XElement_BatchAABB.Add XElement_min
	XElement_BatchAABB.Add XElement_max
	XElement_Item.Add XElement_BatchAABB
	local XElement_ScaleRange = dotNetObject "System.Xml.Linq.XElement" XName_ScaleRange
	XElement_ScaleRange.SetAttributeValue XName_x ScaleRange.x
	XElement_ScaleRange.SetAttributeValue XName_y ScaleRange.y
	XElement_ScaleRange.SetAttributeValue XName_z ScaleRange.z
	XElement_Item.Add XElement_ScaleRange
	local XElement_archetypeName = dotNetObject "System.Xml.Linq.XElement" XName_archetypeName
	XElement_archetypeName.SetValue obj.name
	XElement_Item.Add XElement_archetypeName
	local XElement_lodDist = dotNetObject "System.Xml.Linq.XElement" XName_lodDist
	XElement_lodDist.SetAttributeValue XName_value lodDist
	XElement_Item.Add XElement_lodDist
	local XElement_LodFadeStartDist = dotNetObject "System.Xml.Linq.XElement" XName_LodFadeStartDist
	XElement_LodFadeStartDist.SetAttributeValue XName_value LodFadeStartDist
	XElement_Item.Add XElement_LodFadeStartDist
	local XElement_LodInstFadeRange = dotNetObject "System.Xml.Linq.XElement" XName_LodInstFadeRange
	XElement_LodInstFadeRange.SetAttributeValue XName_value LodInstFadeRange
	XElement_Item.Add XElement_LodInstFadeRange
	local XElement_OrientToTerrain = dotNetObject "System.Xml.Linq.XElement" XName_OrientToTerrain
	XElement_OrientToTerrain.SetAttributeValue XName_value OrientToTerrain
	XElement_Item.Add XElement_OrientToTerrain
	local XElement_InstanceList= dotNetObject "System.Xml.Linq.XElement" XName_InstanceList
	
	/*uses faces of the object as item*/
	local faceCount = obj.numfaces
	for face = 1 to faceCount do
	(
		local InstanceList_Item = create_InstanceListItem obj face
		XElement_InstanceList.Add InstanceList_Item
	)
	
	XElement_Item.Add XElement_InstanceList
	
	return XElement_Item
)