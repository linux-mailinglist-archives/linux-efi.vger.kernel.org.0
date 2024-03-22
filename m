Return-Path: <linux-efi+bounces-847-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304C3886AE6
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 12:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF8A21F23E4D
	for <lists+linux-efi@lfdr.de>; Fri, 22 Mar 2024 11:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ECF3D547;
	Fri, 22 Mar 2024 11:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b="bzCMIZPB"
X-Original-To: linux-efi@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2059.outbound.protection.outlook.com [40.107.113.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455313DBB7;
	Fri, 22 Mar 2024 11:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711105273; cv=fail; b=RxxD2sVSiRZ954XI/q87dEqYMpyVeExZUeUA33g91yPZhSoIGgj7XuIPDqc9JVVvs6m3yLp0F2HY8KMaEkJkOQixbEhGjCHoJKNNjjKskYuFilpCp3jCtGpyIbBEJd3qyfHg4ScQyQPgsGCi6mMAT6pRqvMza8rjb+HN/Aos9u8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711105273; c=relaxed/simple;
	bh=RRNRgJzRrgHITpPO/1LPiUjqYNdV7c9a/xENndFDR4Q=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jqRqY/itaE9NefpK/Y8utetA4DSMgVDF+cDIwOSSWqynIWSm1STneOEsjTykrrPVHCEDZCPPQLDdSdZla8R7RPt6p8OJAPu86IHHazRfYylZ7EoWBBLuFxXXLOAO/qXi+OUNEEeyfvZnnAuYUgO57cf3r9J0wwLPPo2YqE5tXyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com; spf=pass smtp.mailfrom=nec.com; dkim=pass (2048-bit key) header.d=nec.com header.i=@nec.com header.b=bzCMIZPB; arc=fail smtp.client-ip=40.107.113.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaml3W57ulbB1IyBrJfHIqoNuOnQ26gYC1NmaHMaOztUDPNADjPul6PlDvwfbL2i8fuKd3ySRqBcu1Z9iG0w13Ajbk1FWAAFIEr2aTzDwLEymdqhAkLUPbDO2kstAd1qCQxOSdq07JQhotOWX3nvRPGSB5s8VaSqiaOvGK+TeBvRB35ANGqrTeUEug9mEZWpAGUuHE6qH3nq/7k750k+hCEjyRzxtpqJHk+mQAo1KPbl9OIYsovSWH2sIk9QnBbHzxUZNMWH8jO0s7Zq1CpoBE8/gRHKeJlA7SzioA430O5l+2aO6kqe1SHtIoyPBG49uIt2YWefl8o09kYenbRZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+BOConBcylqTq1Rj3MHMFy+PQy5kIsabyWphjNYiso=;
 b=dJEBE01OnjEvenlUHVy9AQ2Sflkv16Lb9UF0yFBsra/nGfjjBs12L9UfIHvZ4qgRHBk66e/GoOgyjMs41Y/Kdr58Wb/oqCyxS6sujUZ6cvjLTWNvNiDyaKaFA1Zrktxv/3k8e32nu/iH+9JfIEkzrajo8VkTu7mp2bG4gIQ06lA6rsLx51XLcx+5r0N+dr7vuLK+UI/s8YZ3PSqVNyyVhM0COouL9K1C6n8xs5+6LgH0dmxLZKmmlhLKzjBfQltTRjgt7EbfVtec3FfZcsfbYGOEGHvEqDrf5Gv8phEiHsWiEqRld3YpDZhKdH4vJGpWtv85yg5NkHBZSpMol45W2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+BOConBcylqTq1Rj3MHMFy+PQy5kIsabyWphjNYiso=;
 b=bzCMIZPBgJfh4xBYUFkXczpX3as+5vuoqsL9AQTPhN+K2UZQ5BBYFb4hFqD1nJId60Q1jXOju2DDKR0iPL/p82Z0lIUtULoeyc6RBxdlAdTiAaCiMuC3zQ8797nNMILXhT9+Spo7KRPG82fPlOJp47MVZMDvNMryLbY4v03rt+YIzTGqJob3+2/CJ2axxW2GHgPJ2mMe0ofX7aAfeR8/UzzJCING3/Fz8yIjsq+jm6OR3YHR0/aNA2hwtYTToM1NIwsdctR18j8ImZ5ylGhXBhbM1MSXqf9L00QCAXmxobpy6Cn0UZHvoez2WzYabG9jHhH4KMIMFbqO4ynQgJVZuA==
Received: from TY1PR01MB1625.jpnprd01.prod.outlook.com (2603:1096:403:5::19)
 by TYCPR01MB5774.jpnprd01.prod.outlook.com (2603:1096:400:44::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 11:01:06 +0000
Received: from TY1PR01MB1625.jpnprd01.prod.outlook.com
 ([fe80::fb45:85ca:f420:e514]) by TY1PR01MB1625.jpnprd01.prod.outlook.com
 ([fe80::fb45:85ca:f420:e514%5]) with mapi id 15.20.7386.031; Fri, 22 Mar 2024
 11:01:06 +0000
From: =?iso-2022-jp?B?S09ORE8gS0FaVU1BKBskQjZhRiMhIU9CPz8bKEIp?=
	<kazuma-kondo@nec.com>
To: "ardb@kernel.org" <ardb@kernel.org>
CC: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"tomenglund26@gmail.com" <tomenglund26@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?iso-2022-jp?B?S09ORE8gS0FaVU1BKBskQjZhRiMhIU9CPz8bKEIp?=
	<kazuma-kondo@nec.com>
Subject: [PATCH] efi/libstub: fix efi_random_alloc() to allocate memory at
 alloc_min or higher address
Thread-Topic: [PATCH] efi/libstub: fix efi_random_alloc() to allocate memory
 at alloc_min or higher address
Thread-Index: AQHafEg9wcbkIIdoj0CvtWchAjlv4Q==
Date: Fri, 22 Mar 2024 11:01:06 +0000
Message-ID: <20240322110058.557329-1-kazuma-kondo@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: git-send-email 2.39.3
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1625:EE_|TYCPR01MB5774:EE_
x-ms-office365-filtering-correlation-id: 188d4d09-b583-4efc-d14b-08dc4a5f5fa8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5TZXEEVVEqzrFdhAEP5xS8WfrVYQwFbuBDiv9KlXTBDfwf3P9dmPlCUGvBZ4sYqVkanP5QFubnWHQ+Sdlsq8d0ReqoObfv4jLJVhetX7YsyOcyApM/lVzQQT725XD+w7rGvNLhZlqvnJ9cGBB6ufLNSUtrK8VufDJVyuiTAmsQioAw4wgOTiN6g6w1kBQiChc82mxUfSlIZJzn7yNHDE8QwRB+GCORnBdKVd+1b2FH1jgVmDD5RzZNU4/fWBFlXG6HntM75T1dM6U46K2V+XrP1ESaadK6O+u9vRjmXC6hvfy2IEPWRbiyUnOoGZgsdV2693Lw7C27aSDcRsr2TQrPD1VECB8ys5Yalw48K5KcQ6nTcjP7+oZl1R9upbp4Kve57Ai+U4GlT+f7i75Z2WM1EwRnFPJYrb+UkFZ90oPpWyT0jOoWmKi4dl88h2WXy6IjFAKh+ITRKiXncQQaPqPzvvnzu9u2dCdshshf9Oxs1na/0fhAKo/AH53PTwFpTJqykectSR5cT1AWTK4UgFZu8wbGBfM8qufp9YqXuyg0yUqS2EdCkFYFtNVJ2De2582+2BkxhSfK9A/6oc0ftmvWt+VpFuxDqyo43YELHHhpZQtUG6xE2PpsDIj5cQxbBy15+6Hg7u4jD7D4hADa03o2XMegTC/WMQ/ZRQFtkKfipM7lhX3WhOB5DLnPeRYmPK/9g/sgq3Xjab5maAiVaH+byBSIrRparInwji+ch6IrQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1625.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?d0RoV2F5SVU2aVNrV2xlbFVNczhHYmRmdmVKWURuam9qMmtMUWlqblhr?=
 =?iso-2022-jp?B?SGswc2JOeDVrcG51YnFER242UnNRZ1JqVDB4VkkwMEtNMkFFUWNOYmJh?=
 =?iso-2022-jp?B?NkNqUG1Rd29PcUY0SGlQektOdUEvMjRKa2w0cFJoNExIbmZ3aW8yM0Zq?=
 =?iso-2022-jp?B?T3h2ZzFMRnNiclNDeFVLUUMvMTJLVEZ2dVFJRmx2RytwRGZXZkkyemJu?=
 =?iso-2022-jp?B?dnhsSndZZUw2enlXY2VMRWRTZVl2ZjJ2ZEJuK0tpL0tpbnZyb2hSOHRX?=
 =?iso-2022-jp?B?SzFVelBIK201bzJyUkZReFg0ZlNWbmlPdUNBaFhlT2Jzc3VhQ29HRGJL?=
 =?iso-2022-jp?B?STFBVC8ySmEyYll5RWF6YlVVZGxjdVlKb29BVm1jUnFEV3NURjljVks5?=
 =?iso-2022-jp?B?VWlpcDYrNm5HNGtKOWFDMXBDb3lrVVZOMDJORGt0aEZQREM0WWFZZE5L?=
 =?iso-2022-jp?B?bTNpRkRWOUVGSUhSN3RPSWUrZ3BCQVp1Tmh4T01Hb3VxM1ZuOTNXb2tk?=
 =?iso-2022-jp?B?cm9OR3Vyd29ybzFaTERBeXFQZHFnQ083V253bldGeTBBSUVBa3VYTHFB?=
 =?iso-2022-jp?B?N1IxZ3FlY0pBYUNZNi90dnI1bFN0ejhkbG5ZTHVHMWlrWWRvNm9YZHdH?=
 =?iso-2022-jp?B?U01PUGJ0WWVjcFVqT3VxRS9aK0ZzNkJGZ2tpN1J5R3h0Z0N4VG1JVndh?=
 =?iso-2022-jp?B?Mk54N3JpNHBzbVFJdG5JbXRxblNqVzJjeE1QTHpJVEo3b0M2dW9Pd3Rn?=
 =?iso-2022-jp?B?Y1BiWXFTV09wbU5KR3QxQnc1UHMxekFEWjBueWdkN1lZcHNrbElmK3Av?=
 =?iso-2022-jp?B?MG9FaGZRQmJvN3NoSEczQnRuQXV1ajVjNi9CcGQxQ29TSmxVR25xa2dX?=
 =?iso-2022-jp?B?U2psWFNhcWdPMEpLeTBYY1pveHpQa0lRL3RiTW40WS9EcktYUUVST2s3?=
 =?iso-2022-jp?B?bSsvVXI5bCtEZEhxOWozYllnNFdaMlpxYWtESitFUnRFNFBybXVVTkdX?=
 =?iso-2022-jp?B?UlRxWC9zUU1QZ204ajJ4SHAxRjMvSnpybG9tOW1ZZTB4WC80OEhrQ0FT?=
 =?iso-2022-jp?B?UGRnOVVUUXlvanJCVmkvdE1qeU15cHZieXpjT2hrelB1eW5JRjFmVDhu?=
 =?iso-2022-jp?B?WjNFREM4aC91My9SY3FiYUpib0JJQnNCZW15ODNJNzVXOGE3WWJpVlNu?=
 =?iso-2022-jp?B?NXIzeVpWUnpHYXVZN0xOSStXalJGSGliQ0l6TWg3UUY5ZEU1RHlNVmRM?=
 =?iso-2022-jp?B?bzEyODRsVmxJSGh2Q1pOZEdLZjRMTEMvSXVZUDFzNTFKVTBQa2hFd1Ux?=
 =?iso-2022-jp?B?bDBrOUJMTzNlcG0rMnBDdm8zeEljMEtDek5nNjN0OGhJOEZqRjRocFF2?=
 =?iso-2022-jp?B?VHBsVDVqMXRoYVU1dXF1b2taN0VXdy9XVWF0ZGVkWElENHFnKy94ZnBC?=
 =?iso-2022-jp?B?VUJ4dytKcHk1N2NWZmt5RWk0Y05iVUxGdzVtZjJMa1hTU00xZkoyYWZJ?=
 =?iso-2022-jp?B?QmpRTi91a2xZU0gwVTRFckNOQ21IaDhvZDdVYWJzM0pjMnlYUjRwM0ZE?=
 =?iso-2022-jp?B?azN5RFZPSnRCcXpkNFJMQWQ3MjkzREh5Vk5zN3hwUW5NMm9sZWdJR1dG?=
 =?iso-2022-jp?B?VTUxZmltMmlnZ0xVZ0taUnlzYUdQZEsvVXYvMVUrMWdHN01MWUZNSDI5?=
 =?iso-2022-jp?B?TU8zcTd1bHh1OEswaEo1QTVma1lvV3Jma21NMjZtb09lVWhhSDdvVzYy?=
 =?iso-2022-jp?B?OU1KZ2JNUTN6NzI1VUVIV2RuNEdZMmVqZHNQaHUwUmF5cGJKRjB6L24w?=
 =?iso-2022-jp?B?V1h0QUdxMGovYjh0UmtkTWl3SklTdnVFUUJIcjdWUGFJUE5YNnM4OEY4?=
 =?iso-2022-jp?B?QnlWWlpsMTFCUUYzMDVFZXYwZDlKWnJPTlJUUmN2THRRRlJEK3ZoNkpx?=
 =?iso-2022-jp?B?YWtrMytFWm9rR3FGMnJTVzhOWW9qd0RaZTFuYlJCZCtURGhleWhHVmpC?=
 =?iso-2022-jp?B?QjJnKzE0MFRKNjNud1pnTjZIcHRZOXk1WDVmRDZCQmdzYUFvK2IwbjMv?=
 =?iso-2022-jp?B?VFFlNFBKQ0VYN2RlSU40NWhpUmJ4R25ZZGIwMTJhS21naU52MFpZZTVS?=
 =?iso-2022-jp?B?M1d4WmNZeEN0Q0NIbkZPUFZnQldZY0xaazJRQUJQTm0xZ09PRnNhb3Nw?=
 =?iso-2022-jp?B?M1RpazFyY3RIbGlOYlE1bklvWWZQVWdhckE0Sm5LcGpPb3E5c0YzYnZC?=
 =?iso-2022-jp?B?YTJRRy8xcXNqOFdNQ1pES01wV0lHUDlwdEk1cjNhNGFvUERjaHJIbjFS?=
 =?iso-2022-jp?B?WFRmODRpOEoreVRkbU5NN2k3S25qM2FGMmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 188d4d09-b583-4efc-d14b-08dc4a5f5fa8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 11:01:06.6637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NeJU3WI20/Gd2q/vPAS9cIW2xk2TcRYgpoXBol0GmY1seRKdBhwxVfoDYmtWIeS6oxy5Orl+KeByeuqEKZtV2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5774

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

