Return-Path: <linux-efi+bounces-400-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A293D82C585
	for <lists+linux-efi@lfdr.de>; Fri, 12 Jan 2024 19:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB4E284478
	for <lists+linux-efi@lfdr.de>; Fri, 12 Jan 2024 18:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B0C14F87;
	Fri, 12 Jan 2024 18:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="P1LMye9I"
X-Original-To: linux-efi@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2073.outbound.protection.outlook.com [40.107.22.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076C014F6C;
	Fri, 12 Jan 2024 18:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VMhBC6C6RRlpknmfJW6kWKljxY1vgBjAh6jQCiDkx7fM/z98XiIHvnFOuehRoCZxx9vmlyUqfEwEl3NlgwTuT5I9QnJP1PUxHaGBa8HbSUmt9thlXW1kMUp09FPWwWT8G6ifty7CcgehuTHJ6iH9TPKh/6JjRED3YQmf+DxhLQa7Dr04n5iTwWiEsUW7K+f93Dv4/UQmGFidVDdziuxosi7IfGcz8SEY/YBEC+Y51pSkTIPf/BSmx8kyz6zzoDyaD/pJxrE4A2oOgaHjq5S1Wzjs5tvSeGI8+s7UYgU1DS/Mq6IBYs0YT8P6ZDNqdKFUDErowpD39EL0xJnuac5YAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/LENPqC9BmBNWPKYaIBYOfpLLIo80zXFYbB2OELyFQ=;
 b=PP4BOqp/NRnXKQJ8zFgzUXxEovnWdUDexzgCfhpsaFyA3qRDnb2MDRvnsVfkY0k+MHFjTpFWzqX8LJ+Ozd9nEYe4NAUtgioGHeokkLy0o7GeDkOdaPrU416Y3D4rTmyyIr3SpktGtARiGHRZk5Y0R+T1m0qH4ucwspLhG0fNq80+2AtZJu3Qpaox8j5M2n/MKtzUFBb6gnzDrZsG1lqHdgvOLrdJAkFKY2xghFFTkSe7nsFhXrCIMyUUDpCbW3fRN9U94g85n/BtTMHrgumO1nb6nP15KyXmtgfjG3tZyfNub6gBQPFkfdmEzNp5Tpl45UCFJyBnBGnhTIEWYHfADg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/LENPqC9BmBNWPKYaIBYOfpLLIo80zXFYbB2OELyFQ=;
 b=P1LMye9IMs24t1QtbdnMVHIAVrsXbG4n8dNifPGO3kc//tRHXrIiPuWeDdeg9Oo/r4ujO3fHOUymemhe05cvCe9gAtNjLfMCZyEdgcMU0BbXnsb5OpxxqXnjlijhlWgshGmUHvdT0peoPp9+oa8LUZir9M8pLJeJ7cchLCIvYrOAKS/ympy8UEEq+hsu7HHu9dxxk9v4lWWhe49BB7KaEQ4LWdZu2aeDoTIKqGy3SQVs0i8Z0Nku3FiPIHG2wNAN9R4EAsWM50Q7ezVjTf9WRnoaWwDK+eqJxE+Lu7XhjVZ7Bgs18tf5aiAM1GiIdNIZw3ohRZQvJFvs2e+IBYcq/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6890.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 18:37:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7181.018; Fri, 12 Jan 2024
 18:37:33 +0000
Message-ID: <42c63cb9-87d0-49db-9af8-95771b186684@siemens.com>
Date: Fri, 12 Jan 2024 19:37:29 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] riscv/efistub: Ensure GP-relative addressing is not used
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-efi <linux-efi@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0259.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e87843f-fdae-4d8c-2374-08dc139d8a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YpsqL4gZ7SI6EkVdFflwHPooIXl6Eabe1bV6iLApzqB6gBuQuJEVzUtvJC7coPc7Ak/ycJN6gR+HOHksTh6gDr0OtyBCuoYBb8QwfGoKs5DC1ycmiUj4FaFJ7sCt8QBvnJqY058gbA1svBS/QWqSbHyqMC7wwdPF5unt28osHnW+m8HG5p1cemeaBdetJDTHaKypN+gDTX9rclZq0uVBrZBWq9BOo9zzb4BaCeOEbyD7YV3FdpjhHvbC9dcEQ36Oe5vj6qyFHdQDSsAKEsnclHG0No7LOwFaYlKSYJg/JrdKEVtLm1T9ndmSoVM+wtXPcEp8XqElcIH4EV+V5p7hcx/YwFMq1rWsowrZocyxokySOHM6JGoFoDjt6jBUr/ULWiqL+hUWlSMRBdVkoGWLBgXPuEH8yxD08VI9iTOc3o1pM/ljdbwFJS0Q7tqYj3/faFms3ksfXBJ4htnLeDjBipGtkEn2uAuwXogySciYzxAECvPVd6Jc5t9IaGL+1WkvhSzT3QREXrpwp1ShH9X+rd3RfClhsU7HbFXvL4CZqKUDtGbTL52eDkY3bIbrRwo7coOts/9gbudgIrjaNSk/KrCkw5aetKNsg/fYOWgS68Gx+D3ZTztudPU+wI4ZolQDb/Phr5kg+h9SF1SHbb4nDg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(39860400002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(44832011)(4326008)(8936002)(8676002)(2906002)(5660300002)(86362001)(82960400001)(31696002)(36756003)(2616005)(478600001)(83380400001)(26005)(6506007)(41300700001)(6512007)(38100700002)(54906003)(316002)(66476007)(66946007)(6666004)(66556008)(6486002)(110136005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QU9zZTRscERuR05BcTkwUy9EN1FjRGNLVFQ1MkVNNUp6bk1valdGZkdnUEQ5?=
 =?utf-8?B?dzNJVFpNb2pjL3dTVzZjejZQOXp4VzAvaFl6MkJCbU1QelZES2phb1MrRk92?=
 =?utf-8?B?dS9hYnRnbG1TMlVqTVlRRUg0bHNCcnpqQVZ4RXFicWJTVFJYbEFpZ3QySjYr?=
 =?utf-8?B?M294UHQxdVowZjQ1anN5R2hBZ0x2TnlLeFlsSlR5bnpoZ3RpbGhhd3VwYjUy?=
 =?utf-8?B?Qmh5NlBUUUtJZFFBckQrWGVWWm1LR3NRSVpDd0MwR1hPZ1Jna0xoWi9mbjl6?=
 =?utf-8?B?Rys4NHVNWVNiUmdFbHQyTjI0aWNyVkdwY3VFQTJkZFpVTkp4OU5iQi9qM29i?=
 =?utf-8?B?Zjd1M3NJRUU4TTZYMi9aQ3JuNCtiN1Z3VEUzSksxNU1DaXhOT1Q5VE9yenJE?=
 =?utf-8?B?dWJVOXo4R2FOY0tKN3dwOXlhT3ZEZGV2TDNidUt1Z011R3BUcFVjVEZ3b04y?=
 =?utf-8?B?M3lCbVRkbGdLMThaT3pLNWZ0ZWFDeEF2WUpCcEVnY2J4aTlYTXd1aWhuMEVQ?=
 =?utf-8?B?U2llWFR4b0JKWDUyTnp0STZTakhKeXp2M1o4MDVwMGl6YWhKUGdIeXRiQy9N?=
 =?utf-8?B?MGF5T0ZjTnE0ODN3N2VET28yUEJFR3FFWGtpWWpQbVhpR0FCTGNiRUFYc2Vh?=
 =?utf-8?B?N040RGN5Z2xMb0xYU0ZFMmxab1N0aXErQXMyWWcxWmc5QXNadUhNb3dCMjBw?=
 =?utf-8?B?c0M0N3g3MGpLYmszZHJVcWROM2VCMjB5VXFISndNc0tzMyt1Q25wUW1iVzRl?=
 =?utf-8?B?T3l1L09ROTBUYnFXQ3FEZVlrNXF6OFdTeWR1UEQ1UVVjcWlHb2Q3Mk5ydzdS?=
 =?utf-8?B?OVJqbVdZcFd4dDhEQWR6dzNsWDZ5ekZMYmRJMHk1ejIzeHh6LzczVDhKZVVm?=
 =?utf-8?B?L1U3ajE0SGMwTGZRR0R5b1BYaXFTblY0cno1a3RuR0RuaUZUM3JZb3VTQy9W?=
 =?utf-8?B?Nko3aU5DRGR1a2xsczBaNldoVlhKOGZIY1JqK2Zqeis4enhGSDAwaWpVQWli?=
 =?utf-8?B?ZlFqTHQ0M1NsZzY2QUpLcWR1TjJtY2RqSWFzTmJYaU1JQWlVNGRCazJ3Q1pm?=
 =?utf-8?B?VU1wd0FBQ29pTWJxOHFHanhqY0dhSnpRUjdBZ0ZrVUJQdjVZVGoxTi8xeW9W?=
 =?utf-8?B?dW9ySnZEak91b0hMMFg5Q2pMQloxcjdtamxaYmZzdmVWMHEySXM0QlExa2pQ?=
 =?utf-8?B?VDlFVml3M0dhRHM5R3hCeE91aXBXZU1rQkhEZGM2MXFGM0g4WXZKeHpmV0hN?=
 =?utf-8?B?WmtJeHByUXRZSEpzR3lsbm40SEk1bG9JS3hvb01BNzlmdzRzWEh3QkE1WUtr?=
 =?utf-8?B?blU4ditIK0J5RkJkT0laUzdSVHBHZFMyMkpQRCs5QWt1SGVqMWhjb0hxbXhW?=
 =?utf-8?B?c0RXcUNHUitNY3UwNkFVbzAxUis5ait2bnc5Ymo4SG5CaXRaQnlXdSswVmox?=
 =?utf-8?B?L09OK0xPcTlSZG1DWGtaSTZPdVBld2JqeGovb0p6SDhheUo4TWtpa0Y3ZmRD?=
 =?utf-8?B?RHU1NkVjMjdXOTlHeDA5OWpCc0o5TDRZdUg4MlZneENWQnNaNnNLeXVRUWVn?=
 =?utf-8?B?NmRFajB1TjZyZC94dUQzK1dHdTIxNlVBMjFjQmFoVk5yV2RFOWh2WTZWRnlU?=
 =?utf-8?B?UFVDVXc3eGpGZVFidXZFLytGYkQ5amtRTW5CSjE0VC8weUlHRzZBVUpwZ2FT?=
 =?utf-8?B?Q3dpRE5xWVRtU0ZwYXpwemhtdlhDM2RMWWgzMzRMWVRkOUM0QmFEeURFR3lZ?=
 =?utf-8?B?V0JWOVY5alYrSjFINm5VTlZ5T0wxN3paYmRYVlJvUFFKdHNkZTQ4MlRiQVJi?=
 =?utf-8?B?bW5oMERlS2tKRXBscEppZWZsdURDWHJ2T3ZtOXNmNXRGS2cxWEFnUG0wTDl3?=
 =?utf-8?B?SE12WWRvL29CL0RUeTJ2ZE53T1RuN3VUMmQ1SEpXYldoZnNsTVB3MzlKbXJy?=
 =?utf-8?B?ZHRjTW9JNzVreGhHS2ZTRlZKSDZzaDR1VG0wTFBIWHJ2UHpTRVFkOEpwSzRu?=
 =?utf-8?B?QkZ0QjU5MzEzTllHODYxeHNOaXU1dHRrWTVRRmRsREpnU1haejM2MGtBVHEy?=
 =?utf-8?B?cnIvL2FyMGJpREMzRkczbUdvbXV1cHhwR3FzeDF0WGc1ZkNFalNZM29RWjBi?=
 =?utf-8?Q?lOsAEuqF8gOOok4hxYw4dp6A5?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e87843f-fdae-4d8c-2374-08dc139d8a8f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 18:37:33.6084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lq62neP7DPeyr8A/pFG4K0mpD0EqPSd2gpk6aj6MHLOxooJ/gUhmv5XVWZ64b9aRU7iGZ82xDkvLBeS5o58wNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6890

From: Jan Kiszka <jan.kiszka@siemens.com>

The cflags for the RISC-V efistub were missing -mno-relax, thus were
under the risk that the compiler could use GP-relative addressing. That
happened for _edata with binutils-2.41 and kernel 6.1, causing the
relocation to fail due to an invalid kernel_size in handle_kernel_image.
It was not yet observed with newer versions, but that may just be luck.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Something like this should go to stable as well, but we will need 
rebased patches.

 drivers/firmware/efi/libstub/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 06964a3c130f..d561d7de46a9 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -28,7 +28,7 @@ cflags-$(CONFIG_ARM)		+= -DEFI_HAVE_STRLEN -DEFI_HAVE_STRNLEN \
 				   -DEFI_HAVE_MEMCHR -DEFI_HAVE_STRRCHR \
 				   -DEFI_HAVE_STRCMP -fno-builtin -fpic \
 				   $(call cc-option,-mno-single-pic-base)
-cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE
+cflags-$(CONFIG_RISCV)		+= -fpic -DNO_ALTERNATIVE -mno-relax
 cflags-$(CONFIG_LOONGARCH)	+= -fpie
 
 cflags-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= -I$(srctree)/scripts/dtc/libfdt
-- 
2.35.3

