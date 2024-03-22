Return-Path: <linux-efi+bounces-846-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E04D5886AAA
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 11:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7F61C218F2
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 10:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67723C684;
	Fri, 22 Mar 2024 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b="jctpyjNi"
X-Original-To: linux-efi@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2042.outbound.protection.outlook.com [40.107.114.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743473A8CB;
	Fri, 22 Mar 2024 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711104432; cv=fail; b=SL8cD2Pb2BMT7JUUCs66PlWB77nRMmawMTy8Av+Fy7EFaj8I1pxWICcHZmjKXBn7ml5O6qfSE+AYf2G+1b1Jcu78W1IQh6gb1AJlOpi6otxjwV1S+KoBOe2G9a5IUMLCtqC66RPtIFhKd3VbWUl2Z3K/puUFrcfmD4ekZsXMG6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711104432; c=relaxed/simple;
	bh=RRNRgJzRrgHITpPO/1LPiUjqYNdV7c9a/xENndFDR4Q=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=P1n0LTcctXSFA0xfBmZ+KCg7/+XCBT6lHOgGGJHW53z6QuJMTlsudaDSx79ZxzC7i72sBJsFNG5DsdQX7YhZTKtdECsbE2GiAbJoJEQZtmIiDdTGgCsBxDk0gvOMmX4HkJ8qrQWsFtDxwMSlhfJhTdeb89fF1tvhVGwXf/9Dygw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com; spf=pass smtp.mailfrom=nec.com; dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b=jctpyjNi; arc=fail smtp.client-ip=40.107.114.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8r2pX3O6dv13K4wYqMECmUcScBJ+yRQhZEK81bFzqtSWlh4fSYpDhbwx7lbcXXNJqUm6k+SKBIUiSMJ4JjK6eR/8kJNngL8egPCtixTOPPP7cOnJffsHQRlNQFSt3tj/7YxZnmLceCd2bW7amFXPOyghHzUT/wb9TZ/yqbHDJkXkoc5q1o2Rs87kom+o7pRwiGGJe5sycYWfj+sn2nd2W0TUK1PeMRzC33fvrt8W4B1uPBIoCNUFnwaK6Z/RMCa8syFKilu5gll9RyJHibt7/7TYD+408tWW0HG0UYHhdnN1Lm2xEXQXupPZJkS9q5masmEhxKZ9IyQ21Qo7LgKLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+BOConBcylqTq1Rj3MHMFy+PQy5kIsabyWphjNYiso=;
 b=K4NEC1hHYiGhoHO2IWQI+j9tgwNxh1L9mhhILPUOVGfWYXqtg99wD20J0H266O1PHqyr96n8NI9ieNPr6VWEFrOERAuFouZgMyVhIvwAAFpftEzIgnwUwQPPk2L68/upb2ymvMmuvMVh8BVjEJ468rGAaBtlR01/Oy3jpSEWtyo9YUnsxSi/JQpualzph4zhlPjSiF0NZnBn4LgI25VMCVKZ95e1UmKV53W9wR45tEu5cIUyJ64VOv9CbnhucdHt45knWH8Ols0g5Xzx/+bZNFA7vkO5jCmUt0iABiuqkYoJKEybQFjJwwBR/lw4VVwWG3Ug97cYVRhOGWlFszH1pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+BOConBcylqTq1Rj3MHMFy+PQy5kIsabyWphjNYiso=;
 b=jctpyjNil2zvY42L8aFZMxSvlCW9BKc0JZJike0Hv99Sia10rKG6StYwf/EvHeFk6i+HYrJT0adrHmWDqzA5QW+58iK2CFqPx0euRv4zykCquAZlFvmr9SXFAUrhw6ZdZxS0s3W5qarWalhsRStXYHdhlLx6nUtTJNbOqEJDmYwQlvs82XBqpaIDcag5xyj9W+p3jS0mmxovSdI01qupvOQ6tfMTmW+yvGZk1c3v1M6KpI1psfGfVvSCfK8pWPIdDWUnzvywRvSeeeOT+za2i1XBIgTxS45UvKEhGNXlS/62L8ab7XwJspPE6E7CF8wnyxtMi5eZA7Vb3ibGWX5tSA==
Received: from TY1PR01MB1625.jpnprd01.prod.outlook.com (2603:1096:403:5::19)
 by TYCPR01MB11224.jpnprd01.prod.outlook.com (2603:1096:400:3bf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Fri, 22 Mar
 2024 10:47:04 +0000
Received: from TY1PR01MB1625.jpnprd01.prod.outlook.com
 ([fe80::fb45:85ca:f420:e514]) by TY1PR01MB1625.jpnprd01.prod.outlook.com
 ([fe80::fb45:85ca:f420:e514%5]) with mapi id 15.20.7386.031; Fri, 22 Mar 2024
 10:47:02 +0000
From: =?iso-2022-jp?B?S09ORE8gS0FaVU1BKBskQjZhRiMhIU9CPz8bKEIp?=
	<kazuma-kondo@nec.com>
To: =?iso-2022-jp?B?S09ORE8gS0FaVU1BKBskQjZhRiMhIU9CPz8bKEIp?=
	<kazuma-kondo@nec.com>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Tom Englund
	<tomenglund26@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] efi/libstub: fix efi_random_alloc() to allocate memory at
 alloc_min or higher address
Thread-Topic: [PATCH] efi/libstub: fix efi_random_alloc() to allocate memory
 at alloc_min or higher address
Thread-Index: AQHafEZF8i/GOaXeBk+/uRPkyUam/w==
Date: Fri, 22 Mar 2024 10:47:02 +0000
Message-ID: <20240322104646.556886-1-kazuma-kondo@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.39.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1625:EE_|TYCPR01MB11224:EE_
x-ms-office365-filtering-correlation-id: 7f492250-5f01-492b-05ec-08dc4a5d6866
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8E9eJ0xUj4mTRrhzwpp7T6K3Lj5rwzwQl0ECYqAvUlFj8jLPSQhQ5q6zrKCvXwFPSVAIAbgoKfLYNfMNKbhX3WWX++W8LWjO2mrAYUrR2lbpAI7XPhLoyDCVqRFAM9o6RTocGeWt0g/EnXS5mBVeiZGdpYiKNICi+T3TOMAlS1TmjJrNnOo1qNjqLsMy+h2puC5qsEGKbWNEjzq0MP1RbR5ZwVmJWgjK+wdnCyKxSjpiIFxGMNNh0AW4tcdq1WHP3RdzyYmXwetxjQZey5sxhQ6jfwHbTU6u6G/vf21oIWP3xjJDyuMGEeLaN3aPKSjD2TCv9HqOwoF3iTPAGuuv5XYpA9BldbTEwGU/Zi9J2CeyEuWAB/sg0AaPdfJ2KL9oGTonuD2lMJfLfe/JLXhnLGekB8zFXEGnkoHXDbgJ7ztbkN6n5p5Za0xAYOdLUT95e+clY8TUvCBa5pq3wzQ83DKktvkBY7040NGtAXtHyePNgMaubLjYyYIENdOC4aG5oNccM7tzpH1b2SND/exKxjVi2+VBQ7xqMm/iAVAaIJL/dvZxiaSNmcnHrk18sE52FOWlq8ceFUGuNOxtKYKXdgknjwwS4mk4QuGjjOcXIbCSvPREmZeb3kw9IKOrkexGLoVHemyNvudZacT1nd3L22jkky4aQ9HVlXSI53tHPVeWtKGfBxsk1Vu4YqoLtizdZwvQvJXMD8woep+qxVH4dVj5udoBb1oP2oYyu+Nc2z8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1625.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?ZXZKN25IZmI3Vi8xNlUxVGlwNGJ4aExRRFhLckFMMkxLcHNDWjRta3dJ?=
 =?iso-2022-jp?B?Yk9TWUpLdWszSTFjZWNGVi9xNnlxVmVpZlJDVTVGTHJ1RXg0OUowY1cz?=
 =?iso-2022-jp?B?Z1JBd2JVSThmdnRQYWk2RDRxb3VZUDNhakVodHpPTDBVMDg1ZDNLd2E0?=
 =?iso-2022-jp?B?ZWo0WlYyQWxOM0ZZaWZSbGFleTgvNGpqbmJSTHNveEpxbEdhMkRXSVBD?=
 =?iso-2022-jp?B?NytoYzIzQ2tub1hDbWVkbVRuWjByRHhPS08rWWZpc0pWMS9MeUNqa3Ez?=
 =?iso-2022-jp?B?anR5TXFKM2swK2dKZ1pZT2drVWdOR1dDVDVtSXJ6OFdaTmxidlh4MXJJ?=
 =?iso-2022-jp?B?aU9VdUwzRVpadTdqUEhMOHhLTUdaVlhBTStRRjNOTjUzQXpucTZQV3V4?=
 =?iso-2022-jp?B?U3puN0NtTTZXaXlRbVdpMmZhNEpSRno1cUNNK00vVEFGYnA5UjUzL1po?=
 =?iso-2022-jp?B?Z0ZWT3YrZHROaGdSeVprbkNlYXdqZkFzd2FtOWtsMmRYS0V4a2x1OFVW?=
 =?iso-2022-jp?B?TUhTcWtUaXR1THowRnJoSTM5Wk5RUXJEMmJkSVp5c1FxajJBR0Q1MkdF?=
 =?iso-2022-jp?B?dWlXRG1DZVl1MDZFeGRWMEFyNkY3OVVWVDQ2WFNBOGY3NG5mTTdxZGZV?=
 =?iso-2022-jp?B?bVFsdjVnV1l4eU5NSk9XM2dkM285RDc4YTU3YWtkcTlOeGFhcGpEdHVp?=
 =?iso-2022-jp?B?N0Q0N21ZcCtxZjk5SGtkV2hFc3AxUkZSWVlsR1N4ZW9ZcHhMU2lEa0F2?=
 =?iso-2022-jp?B?N0pRMFVFcDdJVlg1RVZSaWxIQ09FN1F3dmxycXI4c2JWdml0R2x1Y0pu?=
 =?iso-2022-jp?B?SVlIMFh2dGl4clMzc0MrZGZGMWx1b3RsYjhzTXcrN3dWL1ZOQkFyY1VJ?=
 =?iso-2022-jp?B?RC9CYWRwamNMZmRlUlArcXMydUtOQktMQzlWUlJxVjRhTkt6Rlh5eUNI?=
 =?iso-2022-jp?B?THpTN1VFeUIzMDltZXp0bmhGWjZaN1FBMmh2RlFJU3k5L3M3YzBCTDIz?=
 =?iso-2022-jp?B?ZVNaV2Fwb0tCUWtYdHZRbW9kZk03YXhTSGhaK3FoVllrSllKcjBHTWJ2?=
 =?iso-2022-jp?B?NUhmNkFzTHprUUxmYTBxbCtZMDd3U3RFSmw1bDM1K2h6d09RSVVxSTZ0?=
 =?iso-2022-jp?B?MUZWak1jYWhGdEIxWFp2d29hYzMweUYxeWFjT20zK21PdHVTUTI2czlt?=
 =?iso-2022-jp?B?Uzk3dkJQS0Jid2p1UmdJR0JoM2J2RmkrcXZwdng2VThoUlUwVHhKaVhn?=
 =?iso-2022-jp?B?cE8zclA1a2NJWk9KRWw2MGkwYTA3UEN4a05GRDR2Sy9VeHZYc3RIcHNp?=
 =?iso-2022-jp?B?QnVzNXlaU2RnRHlCVnA2b28vR0ZUcjBVRG5LOWtiNGc4cHRmOUFQb2NP?=
 =?iso-2022-jp?B?V2kza0x0SzJBRFRlQmRZMEJsdVdSa3BtWXYxczh2WVB4VytYT0lMVTV0?=
 =?iso-2022-jp?B?ZGhCNkZHNlVRR1N1TmhnY01aWUlFajRVVUgwc29UMVA0SEVZcXFBV1Yv?=
 =?iso-2022-jp?B?cXVWcFFvbkpqTnZuc2JXdnFEeWF5ZzdPbkdyWDE5UkZEWm96cndsNkFO?=
 =?iso-2022-jp?B?NWxka2YyQTZWSWtuVE1mcXNkdkhKanNZNDRKMTViQmwrVlhDbUk4Q1Nt?=
 =?iso-2022-jp?B?ZFlLcHdRR2pRaFlwWjUzTytsOUlNRUFLallSNldGTHR1citITDRKZnVM?=
 =?iso-2022-jp?B?cGpWa1JlUUl6K0hvL0RMam91K1prTHhwODJCY1FWdkJONmNjSW9keDhM?=
 =?iso-2022-jp?B?V0FvRGo1U0tTNE50bjIrNmhEZS9jdzFabXMvZ0xzbkJIdXpyWVdmMytL?=
 =?iso-2022-jp?B?d3JWTTJ6V0lYeUZXN2ovRWhBWVdJTnhNTlhpQlNYUHI5L0NMK2ZVWjA3?=
 =?iso-2022-jp?B?QUpFVE9WS1lYV2FjQm9qbjI3N05rR2tHdUtvU1FwTXVNVWNnd3hFUGE0?=
 =?iso-2022-jp?B?K2FhY3ZzOEV3K0s4MHJ4NlJWTE9zb3Vsem5SNXdia1RDYk96RjlOVW5V?=
 =?iso-2022-jp?B?dS9XL05sWmgvRXMwS1UxQVM2VloxYnlVbmtqcjlQV2dWVkFKYVBVR2hh?=
 =?iso-2022-jp?B?RXFkaHBMc3pSanFXUDBOazJoMUVsdVZLdXc5NVlrODRjVzhGZXAvWlhn?=
 =?iso-2022-jp?B?WjNmRGxBTGg3ZVlVejN3NFREMmxJUk92dkhqWk1lb0FhZmNqVHhZWCtp?=
 =?iso-2022-jp?B?NFZpb25qN1VkMURsNFJwWHpCaENJVGl5MVZ3c3lubVlBUHNQcWVxMUkv?=
 =?iso-2022-jp?B?MmROQUJMTzNtQnIrb2x0OXZsSmwwUTZTSmt4NjdDUHhRZTl3VkdCcDRz?=
 =?iso-2022-jp?B?RmJNR2dsL2s3YVNlbkVkVHdCdmhSb0M5Znc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1625.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f492250-5f01-492b-05ec-08dc4a5d6866
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 10:47:02.3094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ir3A+/BiIRhpNdWic5LP6vfdohfcSHy04aJ6Zh5+DdFCeD4aRsSEIOrX5aeTgTifHVgQlPjeNb9liZ0sWbNzZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11224

Following warning is sometimes observed while booting my servers:
  [    3.594838] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allo=
cations
  [    3.602918] swapper/0: page allocation failure: order:10, mode:0xcc1(G=
FP_KERNEL|GFP_DMA), nodemask=3D(null),cpuset=3D/,mems_allowed=3D0-1
  ...
  [    3.851862] DMA: preallocated 1024 KiB GFP_KERNEL|GFP_DMA pool for ato=
mic allocation

If 'nokaslr' boot option is set, the warning always happens.

On x86, ZONE_DMA is small zone at the first 16MB of physical address
space. When this problem happens, most of that space seems to be used
by decompressed kernel. Thereby, there is not enough space at DMA_ZONE
to meet the request of DMA pool allocation.

The commit 2f77465b05b1 ("x86/efistub: Avoid placing the kernel below LOAD_=
PHYSICAL_ADDR")
tried to fix this problem by introducing lower bound of allocation.

But the fix is not complete.

efi_random_alloc() allocates pages by following steps.
1. Count total available slots ('total_slots')
2. Select a slot ('target_slot') to allocate randomly
3. Calculate a starting address ('target') to be included target_slot
4. Allocate pages, which starting address is 'target'

In step 1, 'alloc_min' is used to offset the starting address of
memory chunk. But in step 3 'alloc_min' is not considered at all.
As the result, 'target' can be miscalculated and become lower
than 'alloc_min'.

When KASLR is disabled, 'target_slot' is always 0 and
the problem happens everytime if the EFI memory map of the system
meets the condition.

Fix this problem by calculating 'target' considering 'alloc_min'.

Cc: linux-efi@vger.kernel.org
Cc: Tom Englund <tomenglund26@gmail.com>
Cc: linux-kernel@vger.kernel.org
Fixes: 2f77465b05b1 ("x86/efistub: Avoid placing the kernel below LOAD_PHYS=
ICAL_ADDR")
Signed-off-by: Kazuma Kondo <kazuma-kondo@nec.com>
---
 drivers/firmware/efi/libstub/randomalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/randomalloc.c b/drivers/firmware/=
efi/libstub/randomalloc.c
index 4e96a855fdf4..7e1852859550 100644
--- a/drivers/firmware/efi/libstub/randomalloc.c
+++ b/drivers/firmware/efi/libstub/randomalloc.c
@@ -120,7 +120,7 @@ efi_status_t efi_random_alloc(unsigned long size,
 			continue;
 		}
=20
-		target =3D round_up(md->phys_addr, align) + target_slot * align;
+		target =3D round_up(max(md->phys_addr, alloc_min), align) + target_slot =
* align;
 		pages =3D size / EFI_PAGE_SIZE;
=20
 		status =3D efi_bs_call(allocate_pages, EFI_ALLOCATE_ADDRESS,
--=20
2.39.3

