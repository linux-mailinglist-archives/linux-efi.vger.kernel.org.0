Return-Path: <linux-efi+bounces-1914-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDA1991F73
	for <lists+linux-efi@lfdr.de>; Sun,  6 Oct 2024 17:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E7D0B213A5
	for <lists+linux-efi@lfdr.de>; Sun,  6 Oct 2024 15:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482BB185B4B;
	Sun,  6 Oct 2024 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cjTKKP2E"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A856B185948;
	Sun,  6 Oct 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728228984; cv=fail; b=ghqU09MYkeiviD8PR7UL/xxw4R08tCju3JIlWndPdYXXJaKuSrHQZas7sodNwnCpxDYQw13HobBc4YaieBTEKL1uus/5iFR1cXpC7CUi+w+J1y64D4x1pUiVLrCmDUIUdtHQqe4Iw9fRb6dZqYD3NONQEyL7dOupkiW1kzz/kzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728228984; c=relaxed/simple;
	bh=XhAdjRAKmJpgtwf3jd6QNXMK8fN4OoP5NACE+NJZ5dM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VdtdeMtzAjdyR9bsDPQ85icS+cY5qKtlQ6ICJxoDAdlyza9bLWFDyS8qeGr8WMmkgsq9Ew6u+ELXE8u5MX7pcIAVMEYPbLQLTKw+psQwcR8ZovuNVkwGSh1elAK79fSn2dEe3lNhT5FHVPH0CtbxFuxxl1fZmbLQ37l5rUOVcFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cjTKKP2E; arc=fail smtp.client-ip=40.107.223.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jk3uQFArVk0ipnd8d3Zl6W/0lttT462PQwfqOA1EHUNm6ortNrfOe4k/H60HW90DpEEVLdou/3la1eX5iBn7l0Sf7Gk0jpeqQUdL/tXG3CA4PwrtZ8FsxzMsIUCC0dTuAPOCVXUs4dAd5oUOk9iyBBkVcpWiOedO6b8TZRsTJZ2bdmgZ1D+9/DzSds2q9FhZmDa5SNkW6Q4JdjrZFOGxuxa3PzfAN2LeD19pvOT1QKHtEmHhr+L8gTiMMQq8om2Q6WhL6hYtyaiFj+uFudbwJiGbkZ3aXb9a8dyz+YpxlcQJkJLfnX/DhdtB1svQyp5i7fF7BOkRxGpFhwYJYRQYvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KEmlPTD0HOFtprOtFXo0+sQxqo0Sl8vmGDePiw+CXTo=;
 b=HBsaGRLPIZJdc+0KoRB397sCYh5N8Bv9vI114dKoWcKMOUBzEy2fCfLdCvJtg1QW6D3xWiA/xkNMstKIpxY9bjbpK3AyGemrfe7l4NxRI8w+FsMxmTEEKdMbjfx7e4q2bHXu0m4TT3VDsnyfEs9y502+Xl5JlyEGmRb9FP1+1y7Dj8lZCf0TyU2Y6ANLnIlrVRY0EehQmcr0XnZwQTTyZVmAVFBjxc4TyJfBHZXpwi9Tsd/RgVSsMU/c/sHDqTpNl6+RBYpeeqJ6UYss/rQ5KmtEPOnw7B8u9WYpq77sCCJWZlcRy663kdu0ssC+eicc1M032TN/NNUOfNcs2yHuHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KEmlPTD0HOFtprOtFXo0+sQxqo0Sl8vmGDePiw+CXTo=;
 b=cjTKKP2ElVIsXkdQshnroZiJi6M/sfziKuNB06EjqppVckeRZsBEfBEAjK3Ce6szITKQdbUgpK3K2OQqVzIpkhYLRTMrDrb4z7ZkFjlbqbuM/l5SLwziZwav/NTZqt1ddacNluvs+jKlS8qmAP1XFDoYQmO3vepllnh/y8sUJZsWir8SgrWo1CeObQpVi0pnl9+pJI381DQLC/wT5AmCWwiEDVOpVht7Cq3bqIsicytEUpEYBmDI8wqn8EQpxagNHRH6d+HVMEUhdXBMfVFStPQstU7imG7OrQ9lBy5cSuCnH2KPnUfUSF/TrxiBdRnR3dNMqmG0+uE4b/u1FkmShA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Sun, 6 Oct
 2024 15:36:19 +0000
Received: from IA0PR12MB7579.namprd12.prod.outlook.com
 ([fe80::da98:f83b:ca75:64d5]) by IA0PR12MB7579.namprd12.prod.outlook.com
 ([fe80::da98:f83b:ca75:64d5%7]) with mapi id 15.20.8026.017; Sun, 6 Oct 2024
 15:36:19 +0000
From: KobaK <kobak@nvidia.com>
To: Matt Ochs <mochs@nvidia.com>,
	James Morse <james.morse@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Rui <rui.zhang@intel.com>,
	linux-efi@vger.kernel.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 2/2 V6] acpi/prmt: refactor acpi_platformrt_space_handler to drop gotos
Date: Sun,  6 Oct 2024 23:36:11 +0800
Message-ID: <20241006153611.1165482-2-kobak@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241006153611.1165482-1-kobak@nvidia.com>
References: <20241006153611.1165482-1-kobak@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0047.prod.exchangelabs.com (2603:10b6:a03:94::24)
 To IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB7579:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: 0346090f-158e-4a21-4427-08dce61c9f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?imkvKTgu1au7kqPqVUQ5hzRI2uNerGBoYvEVPFA2bj1/ah+Ip+PUfzDWle7O?=
 =?us-ascii?Q?trFUNSqD3BNNG7yuNZsVaEyQNpsUEr7V+4q12pbEaJG1M3bHKR7woFYrJc3Q?=
 =?us-ascii?Q?sPuS8mX/UJUN2MOr+PAXUQebXHSkZoqLygWpIDm2rt3rXSc//QjwyYFMpsLj?=
 =?us-ascii?Q?tRMxYRZlswNWmq7awQHHg7FEjZx21Fw8glbV1YlEn/Z0Ld8cWBUQUTtW1bB5?=
 =?us-ascii?Q?FKuDtmcuixbbSgDlXAUlRBfU1qTxaF5FGvlgkE5uZsFSW4j+2NPFUz8Qyw5e?=
 =?us-ascii?Q?M2uAK1/ewG78X3kaz8weJ3BNOzYE354Xm4h/DzUt6dZo1NGMaWEK1AxLfYqC?=
 =?us-ascii?Q?nTqp57rG6HUjLOD9Lh7gR4ZNfiG9sBIE96jg9FDm4ua139UnWLiTVbI+KoiR?=
 =?us-ascii?Q?yCGALXwssBSof0KBfelrP5huVeGWjbwf/5KkxQ3eWy2bDUYW8ya2xg2nDz6r?=
 =?us-ascii?Q?jEej80Fi4vapZDUZGltgAQQvXDZqvs0sHKKxjDbOLhilFRYLqkZf5dww1G6O?=
 =?us-ascii?Q?awSFbUzRPAazaqpg35KWI3ASFnQynZGLXYekwlnLRnzztNRCWudGKMpdrLMg?=
 =?us-ascii?Q?3jc8Te1EPmv1ISI8kdj+FRbXo2Mxf0pYtnuCSH7zzuNFenPY5OFXhunmRkdt?=
 =?us-ascii?Q?50y7gnJm8QC4iMnkj7pk1+G1MtsNSZlaSlH+Mpm+AlBr5Nsv/fRVTPdhOyNt?=
 =?us-ascii?Q?W65/ZV0lN5N23jL1hnHKHjO8LYxuSYPUspG61grnv9xJu26yhivZhh4/tD//?=
 =?us-ascii?Q?CeFWlZyScq3byIyQnFGTlbYABgOk0Zhl+agjZWCzo6pn0MJcUTP1GjdixUHO?=
 =?us-ascii?Q?QgqLfHHqqoYwRYA6ZpLEsvBUxF6tfdbbxaY8yJ3eFibdCPZzDnb2lZN7+Zkn?=
 =?us-ascii?Q?Miozu3t8WTJCw2w/OKzzppDkr7d5Wzm+BtO3j/FROLx3ujHE5E37QdNUOMPc?=
 =?us-ascii?Q?FSDnZ4Ka7R1zMFObrgejCzPTgU2DUmvPISfkt+OFwz2/nk30OMonu9Gupt7S?=
 =?us-ascii?Q?GBqR5cDhcjkWAiuN68fVtTHx4oxJ8uyH6/nLjW/h8m2kQs/RLuuI2TXjzyFX?=
 =?us-ascii?Q?YAZl8Y7N8QIbEdlvyB9CYunhIIQKqOdO2m75hZ/vADAvltQ2oYF2zyf+CkuL?=
 =?us-ascii?Q?USwJIlGgf1yKaKzD/oR2rTepgR9GutIbYZYl86gsQRcFtfoPh62k6aTg6Hil?=
 =?us-ascii?Q?LjEWPaRaoroghjdgDEbYcSaCHvxPy2go6KzRHVxCqChYBgv5TQmpwrIbmNtg?=
 =?us-ascii?Q?ypamH0eJ4cpVV1JSP9mNTdCkBMbNnhh+Utd18xsqFg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7579.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?swjgy7dwdde7WxxyeIzPxl3mbpONi/2uOdaagMybXUxsgKAyowOCSt8x0H2A?=
 =?us-ascii?Q?6S4u9TF09tVl35nOBszk32xypJvrhz/fWj31Y8XYBNYkL0ln0pvCxs8skzXS?=
 =?us-ascii?Q?PyLg2feBMMrdIQx6AoXCh63HPVhwW6xPy2H+6RUFG9uiBV3V++WgjiSWd0F4?=
 =?us-ascii?Q?jEGbu7I2MdvUxuD354LxlhjmfdVQZV1DVNrIMCz/4SEkRM/E+G1r/ked/a2+?=
 =?us-ascii?Q?QHas3gcNDR9GkeVJymd1j0QuyIDIpYGDgUvNk+2ZSDr0hhHJSmzTVoM41YCT?=
 =?us-ascii?Q?00DRkxmkhlVdreutd0EiDH0hf2ywZquoSJqU5HcfOKiW+WPb/sAbtGTxbByv?=
 =?us-ascii?Q?lUsJyAw5i//TOudBAKfZ1ETkdZArec7Qpnstw6zwkAW1CUwXUa4Bw0bRVDX9?=
 =?us-ascii?Q?9doYrlsx1vt/TGMubtXDwocRCUdPXi9qJk8e1kbRqPiBDRF3SJ95YHgCBTJm?=
 =?us-ascii?Q?SlpCmaV4kfrv493t/ev2VANY922Bp96rKiUnrNpyfBXUjU4bsZv++prmnzhv?=
 =?us-ascii?Q?4jbfEhXLjaGxvO8NrJjdm8Z/GaPs6yWfrKNgxp+OMQ/gxTWTEt9e/Di5KkSi?=
 =?us-ascii?Q?B7m/HddorsBwJ1CHFruL3i9gW+V5n+/Sm6t2jI58yMfgAeiaprTU+Ay/OcAI?=
 =?us-ascii?Q?vMn1Vwy84p2QW7mazf1nemOmstM7oExm7A2MWtqxQOp+h5wpt6XU191sWbqb?=
 =?us-ascii?Q?CTeiVB4137clS00AGamvfG2F+QK05OFl3xUCrzq7OLx4qDv2njjntGlAV+4i?=
 =?us-ascii?Q?C57nriqMGBZHcLydDh7hVC3IMWnkp+6KanSPWmnO/wHGp9zIPKvq7u7hsSPj?=
 =?us-ascii?Q?NN6HamimqznTR6dStKwOnq/cAl6spvjE67mb9LmxVivixO1eDSnJ0MUxIng1?=
 =?us-ascii?Q?Evj8B6Zxps/HZGaa1y/kjxQ5q6MlWg6FqlSEDgfiLh5SZ2359yLu4X0MsuWd?=
 =?us-ascii?Q?mgfQQSTq3gS/V/WGphmSt5ma6j+Ii/k58WaxFNCPs2pCARpqEn6UMvtMWwAL?=
 =?us-ascii?Q?opWbsa2vTzr/rxkm1FziJKMMfZtusYvtigZqPXOx200h0dwrIcefu0+sFWlH?=
 =?us-ascii?Q?qrndI2L5NJIseJ4Age2lp52lvzN0WrmaojUENS8JONy7ZNcL3ov4m41YQwt+?=
 =?us-ascii?Q?ELFjR1tob+fIQt8cQcQUeE4tefFX0Nq2bi3nc66ecuC4KdskY0pgVOrLnq3g?=
 =?us-ascii?Q?xOj7EOSZU4qs2sG7jw3XCxfNFnqWACG/3JrXnHYkxIikUG7ln4VDdcmSJaOX?=
 =?us-ascii?Q?JceXvS2DeUV91gzGWmrH83LwLv2OJNt98WjW+GTpFOjpFMMWcIKpT6plIj3I?=
 =?us-ascii?Q?EzhF/IdvVSeAw1I/MCug24hzlpCm4zdZBMUqEHCwvZwqlJhpfSz3FLVHx/p2?=
 =?us-ascii?Q?u+HpN4rsUxgLe6Iu7JmEsMR6jeY630dca2xAiXcHhrN4xYjCio71PM1U9gKF?=
 =?us-ascii?Q?7h6shHnlE3GVeuPZZgmy6subnpZXaqXgIFL8X0DVbEuH99hyrU1yq4Hg6hLL?=
 =?us-ascii?Q?UoWhCRAuxylHA+n4nkWdjZuhUN6J3/5f5Cy3OvcyzWDK62sN14Bl033Xv4Qn?=
 =?us-ascii?Q?bKEbz/HYqiZ27ucjUZGh6BxoIkqcV7AgSDht/8zE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0346090f-158e-4a21-4427-08dce61c9f6c
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7579.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2024 15:36:19.0398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/X194UDJPxXYuCqrhGPVff2Eu7lWBNsuNGwv1n4mafbWo7nhyGvpzMyCv4vsGkNHCbQefvJFZryp9ECUCCYqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487

From: koba ko <kobak@nvidia.com>

Replace gotos with returns

Signed-off-by: koba ko <kobak@nvidia.com>
---
 drivers/acpi/prmt.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 970207bc8f4a..b0cf4428f7e3 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -288,8 +288,10 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
 
 		handler = find_prm_handler(&buffer->handler_guid);
 		module = find_prm_module(&buffer->handler_guid);
-		if (!handler || !module)
-			goto invalid_guid;
+		if (!handler || !module) {
+			buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
+			return AE_OK;
+		}
 
 		if (!handler->handler_addr || !handler->static_data_buffer_addr ||
 			!handler->acpi_param_buffer_addr) {
@@ -318,8 +320,10 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
 	case PRM_CMD_START_TRANSACTION:
 
 		module = find_prm_module(&buffer->handler_guid);
-		if (!module)
-			goto invalid_guid;
+		if (!module) {
+			buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
+			return AE_OK;
+		}
 
 		if (module->updatable)
 			module->updatable = false;
@@ -330,8 +334,10 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
 	case PRM_CMD_END_TRANSACTION:
 
 		module = find_prm_module(&buffer->handler_guid);
-		if (!module)
-			goto invalid_guid;
+		if (!module) {
+			buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
+			return AE_OK;
+		}
 
 		if (module->updatable)
 			buffer->prm_status = UPDATE_UNLOCK_WITHOUT_LOCK;
@@ -346,10 +352,6 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
 	}
 
 	return AE_OK;
-
-invalid_guid:
-	buffer->prm_status = PRM_HANDLER_GUID_NOT_FOUND;
-	return AE_OK;
 }
 
 void __init init_prmt(void)
-- 
2.43.0


