Return-Path: <linux-efi+bounces-5329-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A50C2C29083
	for <lists+linux-efi@lfdr.de>; Sun, 02 Nov 2025 15:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEA80188D29D
	for <lists+linux-efi@lfdr.de>; Sun,  2 Nov 2025 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADF51C3C11;
	Sun,  2 Nov 2025 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eySvQOfX";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eySvQOfX"
X-Original-To: linux-efi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46E881ACA;
	Sun,  2 Nov 2025 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.66
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762094890; cv=fail; b=f7K7BHmOxEEW6k4UyfavDNLA4p+El3ylooNXYPx7pcv2jxv2ziXapHlm3jGqjXbM0tJG5ofLiq1+OgzXffKW8bOn1CLJk1RADwV/zytpMvYtqCIHbdgMShqr+wh6l6xO3Y460oJ7cpnTh9cAVIUOIIA0zUFreLcidtgM8VCTik4=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762094890; c=relaxed/simple;
	bh=b/WNf/wCdiqdratWA+qMiY59+L2cw4E3xzVdlOQ6db0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CdzD5BBH2gT+uxz4qk/p9+uzjd9WPYm8sm3Q6/q0/gI3E6Bar7HJgBn2B7ozVrrT4njBNtgUu7d3Fgw62QY8TO7Nc2xLQRC1OoSnAqsZ0FI7vY9Ht3kDGRchXIg1CGOby7gRbMU1PLYZsGNxyFiNwPghyEtB97ChvQshbsYU6rw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eySvQOfX; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=eySvQOfX; arc=fail smtp.client-ip=52.101.65.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xjRFLVDhQ+/ENnKpvTX30ILgEM0pjGT1SeUd47uPfsLKJ3kAQRNi93WmXLTT6pEJhqItQtaJ9upOYCNgKC2vsbxKeJWE/OYxNgnwnhiQ2RFNK9i41C/F6JlZ/DEuNLv2IqAicJs0hJL9huFFOYSEFOIfpw4es8iueWGQI27/HzfKtLhyX5cxpTT5t2o0d9ZTuJbQnJuJn7oCGDjTe20r+ZDPwk7Y0Ry3/ZTXCqHgqpzEksSu/5Apd5T+T6A4Y8Vfa+ErA9DUH2GdcnhuwHjGrNut7hOa0wUcIcVF70MXIgprtJJD3i2qPFY+o4fKKny2cDfLrGkTtAFPcUOt+f9GxA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/WNf/wCdiqdratWA+qMiY59+L2cw4E3xzVdlOQ6db0=;
 b=bz1BLRlqrqpVDeP0E3zNiw4ck8jFblYtMyksuRTxu7I+ukAxJuxEkPpZeD020TNbCOASOuR42OkdrPlBvI6NR4Qu2PwELzQ+SzeMN6VUmW9CoLNlhpIIjfRor8x6Vxur3jOYAdOOBLBuPTgTfh5WJey4xma3W0h+IJXW1unzbRNZJNqQEOZusy85ej67uPsi0IYwTBTJaZK7rmEj0DrFqLAcoVYY0QMMZSg1ZWVf/6F4mbP0BCMB7QmHfibwiXP4QMwDaHeZwzoWdQCq9KXDx9SnYgKGCJpwTZnPIRbzjuQBH0a9ygpZXU5ZRE6ZQl/r1AIKMOeoMdYWV+VlRivLyg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/WNf/wCdiqdratWA+qMiY59+L2cw4E3xzVdlOQ6db0=;
 b=eySvQOfXSOC1fdl6Be+2icHdNkz2vrXMNI2BQmNGAOskcgoWSg7egybNfbOURwX4CMEmiv9JjyqzhAA7iJ67XYvXqE7jP5MIB0gwluBTpLK9oOIspP39YLPAkT/uCJ12/r7mCpJ2XoKS/XYCFma+g/14fH8FHE4xb2jObR6/1K0=
Received: from DU7P194CA0026.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::23)
 by PA1PR08MB11643.eurprd08.prod.outlook.com (2603:10a6:102:557::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sun, 2 Nov
 2025 14:48:04 +0000
Received: from DB5PEPF00014B8F.eurprd02.prod.outlook.com
 (2603:10a6:10:553:cafe::9c) by DU7P194CA0026.outlook.office365.com
 (2603:10a6:10:553::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Sun,
 2 Nov 2025 14:48:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B8F.mail.protection.outlook.com (10.167.8.203) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.6
 via Frontend Transport; Sun, 2 Nov 2025 14:48:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=huz0bRNi3VvhUbpAtEedKqaxOraiZ9nLwd0JEKCcWfHELkzjNSAGMG59q3CdbZkg9f3MLs2qxx+3XgDRkP9WoUFh8gRyWYrKe44w2WESpYIMtvrOjjWc5ndc0cwpQe76NgWy5OGla1vjytDsyeljbVlDe5k77pJdcjHrqp18r1IrnjQ410I3Ho6clT7egHUTdVggcU1le6t38U7/1G3VM2YQOPLV/adVqij/WklAWJ9pby9wgaJHQUSr9J/DdpT56OHJ34qcGAbIeZ09sPYax6K4lIY6veDqgM4gz4oEaDQjjJ29rd46ENXWlZww/Xgud4rRORSlJYNT0uJDV8jMkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/WNf/wCdiqdratWA+qMiY59+L2cw4E3xzVdlOQ6db0=;
 b=LZNcX4m5h+4zncV+d6DT9h/e1lLFkr3trcZTKUrOT9ClbyQV/IRcLPbUfOsjQcYnufU8x0lvZUrMJXpbSC4/cSwTdFPnG0fhXILE178lSw02C2q8FbdkMQ3AANvT9NyFdj5osrZ0LF2+sLAIXwOQ6YPO8LCeKqoyOmSfbXUbLQNobzNVXwsw18czXpEGz50k0DEw6or8OtH+WVrhT+/Cv/A6IDhOxb9MhJGyy/KnZVq5jKrS9M9YO98IafHU+gIQnXmFibJCNSghwWi8DeIKCAhdei6srtRKVAUM9pJGzY8susxTTxzxRe+g2n3oqHJ2EakgPcTVEMMlcuDRjRRLCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/WNf/wCdiqdratWA+qMiY59+L2cw4E3xzVdlOQ6db0=;
 b=eySvQOfXSOC1fdl6Be+2icHdNkz2vrXMNI2BQmNGAOskcgoWSg7egybNfbOURwX4CMEmiv9JjyqzhAA7iJ67XYvXqE7jP5MIB0gwluBTpLK9oOIspP39YLPAkT/uCJ12/r7mCpJ2XoKS/XYCFma+g/14fH8FHE4xb2jObR6/1K0=
Received: from DU4PR08MB11151.eurprd08.prod.outlook.com (2603:10a6:10:574::13)
 by DU0PR08MB8065.eurprd08.prod.outlook.com (2603:10a6:10:3e8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Sun, 2 Nov
 2025 14:47:29 +0000
Received: from DU4PR08MB11151.eurprd08.prod.outlook.com
 ([fe80::385:c43f:fa4d:86b4]) by DU4PR08MB11151.eurprd08.prod.outlook.com
 ([fe80::385:c43f:fa4d:86b4%4]) with mapi id 15.20.9275.015; Sun, 2 Nov 2025
 14:47:29 +0000
From: Samer El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
To: Jose Marinho <Jose.Marinho@arm.com>, Ard Biesheuvel <ardb@kernel.org>
CC: Adriana Nicolae <adriana@arista.com>, Rob Herring <robh@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Boot Architecture Mailman List
	<boot-architecture@lists.linaro.org>, linux-efi <linux-efi@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
	<devicetree@vger.kernel.org>, Tom Rini <trini@konsulko.com>, Samer
 El-Haj-Mahmoud <Samer.El-Haj-Mahmoud@arm.com>
Subject: RE: SMBIOS discovery for DT platforms booting without EFI
Thread-Topic: SMBIOS discovery for DT platforms booting without EFI
Thread-Index: AQHcSmHkH/Iaw4BeSUCctZ8nwNsJO7TcOOyg
Date: Sun, 2 Nov 2025 14:47:29 +0000
Message-ID:
 <DU4PR08MB11151404912A3A7BE565BC3E690C6A@DU4PR08MB11151.eurprd08.prod.outlook.com>
References:
 <CAMj1kXFJCukumMNBmP=Js1EFJrCVcw5_jfxp8SA8Ff1k6j+xXA@mail.gmail.com>
In-Reply-To:
 <CAMj1kXFJCukumMNBmP=Js1EFJrCVcw5_jfxp8SA8Ff1k6j+xXA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	DU4PR08MB11151:EE_|DU0PR08MB8065:EE_|DB5PEPF00014B8F:EE_|PA1PR08MB11643:EE_
X-MS-Office365-Filtering-Correlation-Id: 48884d3b-a51d-40c0-49fe-08de1a1ed2eb
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UERUR3luVmNtQjZhR2NDMGM4bVZkYW9EVUFoeS8vSWpqd2d0RjZDSGQrdWZq?=
 =?utf-8?B?bTJxQjZQb2F6TjVzbE1GN1hFZE14anJmVGdBOFZoMmpJcFBqckJveVNKMGRU?=
 =?utf-8?B?TnZwME1lWFNUWFhibnowVWZRWncrdG5GWCtyK0JoaTMyMkd1RFZyVi8wdjU4?=
 =?utf-8?B?bU9jTFM4TmJVQTV2VmJOV1ZZOTFJNHl6RFBWWk0xa2k1ZVBiWDhHOGFyTVJB?=
 =?utf-8?B?K2xxQ3ZqWUYyZWx0NkxNNE9BWUNCNFRGM2p4Szd1N0hWNjBtM0NkVzlWNTI0?=
 =?utf-8?B?UnpjRkhPZ3BmYjRtbmh4cEJLRDFpNzBqcVhvQkFoYXJKR0lMRHR5Z1VuRlk5?=
 =?utf-8?B?WTZJWHhlUDlNb0NaYXpJWkkrTllBSUpxRzJrZFg0V0RCWThtbk83aEFDTE1L?=
 =?utf-8?B?NDZ2Qnlodk5UcVF1aW9mdmtjdmc4Z2U2MGM5a2xGTlBsd2xBOCtwTXNUcjVx?=
 =?utf-8?B?bmp5anRDTUVYeWVkTVl3akFjaFJQZDZuZVF0VU1LQTRha2EzNk55REV3WWVT?=
 =?utf-8?B?bHJCWGxYSzFRQzJvZ0EvazdXUVdYVDJIMVVlOWRWREEwbHhUWHdMNGtQMDdq?=
 =?utf-8?B?SW9kblBkRWgvb1VsdVlDZHdLcEdud1lzN0R1VXM0dTR0SFBlSnQyeFUwbngw?=
 =?utf-8?B?OXpPeUMvNGVjYnJjbWxsTFhlWVJ5Ny9XVUtyUGN3L0JlRm5zZXk3Y0pSb2lI?=
 =?utf-8?B?bGx4dFQyWjZEcTVTMUFkUlZBR3VIRXI0Yk9xVXl5LzMyNktPOEZrc0RzQUhU?=
 =?utf-8?B?Ti81T3VOWTVmTEwreWQySFpDUUE0R2lKVm9sOS9BZ2w0OGh2T0NVRC9HdjlR?=
 =?utf-8?B?WVBBMUpuZnkzM3I3SzRObzZXclZIYU5TVnBHb2pMMk9ubi9lckxQK1dKNUlo?=
 =?utf-8?B?eEtDbWhETEp2S2ZtY2JLSkc0aDBkQ3FiU0lNY0daY3hyOWNHR1d0RGNmaWRP?=
 =?utf-8?B?QURnS3NiV3ZUa2h5RVpEaHpUQVMwNVp2anBPZEc2Q3NvaHRETi8yVVVHS0FC?=
 =?utf-8?B?bm9POEtob1ZSOUpmcDVaOHZmNkp5cmYvelFtaGZEajNaT3BTc0FLSm03TlNS?=
 =?utf-8?B?MWh5QStOc2liU2NiVTRqSHVnTzhjbi9VTGdBUWxLRitERFRUeUE0ZVczUkx0?=
 =?utf-8?B?TkxVazlGOHdrV1NXWStFYW9ZV2kvU0VzRUw5Tk53dHFSUCtMM1kxWlpuOGU2?=
 =?utf-8?B?WjFVU1lwZUxGR0dCV01TdDBobzY1enVBcnA1THF5VXhKTUhxRDRDWlBMMWZZ?=
 =?utf-8?B?TWRRWUFFVDhjYXNaZGpwNGtFTTZsdG55dnpuZ3BMbXFJMUxZdGJ1Njk3Smph?=
 =?utf-8?B?dmM5RVJMdFpHbHB6Mmc2ZHIxZnlhMW1mM3NRN1BaOUljeFdJOWZDOXlrNHI1?=
 =?utf-8?B?d0FzWXIyK05WRjVCb28yVjlaTnNNc0k3NGNsRGdkU2poMUhwQldGb1FZaGps?=
 =?utf-8?B?alRsRGZlQ3E3clhVZzJWL3lud1I1bkFrSE9zaGRmNHFZeGtzN05HTnh6Um9J?=
 =?utf-8?B?U296ekxxbUlCN2ZYRStaMXRHZUlYVTEvRVhTVlpza1VqcEw5eHY2TS9nY0k4?=
 =?utf-8?B?Y3dZRVpZMm56b3E5YUxKak94ZEhKQlcvaDRqRXVSQ0RhQnliTDEzdTdtL2hh?=
 =?utf-8?B?YXRNSndTc0ljSFB4bzhMVDlZZ1k1V3I4Z3JuSzJRblk2ZzRUMTZMdmg1QUUw?=
 =?utf-8?B?Q0hBWHF6OVlNZE5mNkc0TlVwelNHQ1YwQkRwZVdVRFV6dWpZbVIzYXliYm5U?=
 =?utf-8?B?UWhMdkxyUytXRWZFeC9GQzRSbktXRmVGQ2oxcGhVakJacDY0aktTRitUbmtK?=
 =?utf-8?B?bGJQa3I2dktFZXFGNlpjcXF0RWpsOXgyWW81VzZ4TjViWTh6cmU5cTFKU2h4?=
 =?utf-8?B?Z3k3eDBDalYyeEU4OE5qTGZ1eGxtWXdnSEJpcDJEUkQrSi9nck50Vzg0OEs3?=
 =?utf-8?B?d1Q5aUh1NkxDb2VYZVRsemlWa3BGTnk2cGJKVit2UGdKVFkxUmxVOFV5T3da?=
 =?utf-8?B?ZWw1R29GTVpRPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR08MB11151.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8065
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	26bb2cef-aa26-4615-15e4-08de1a1ebf16
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|35042699022|36860700013|82310400026|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3ZyRkkycjNCUlFjRTJIRHpiVzRjUDJYTktYSkhYTUJ0eloxNTZPSXhCS2U3?=
 =?utf-8?B?b3U4NkFRTGFINnhOcjBMUEtEY2k5aFBHS1M0NlFCdFpncFNuaGVMck5iN1pn?=
 =?utf-8?B?SHVwR2h5ZGVtS1JvTGFVa1p1SEZOaDUzdDFSdWhVN21kQzYwU3l2bjcySWJI?=
 =?utf-8?B?dTVEdVZLb3BQQWREcGk0OStUMFdSeXJOWVM2bWxsNG5USXpHNjZsQm5FYmdZ?=
 =?utf-8?B?RXNsZ3ZxWFdFdTl5TW9JMU5JRlBVTkh3NWRXMmM5NVY3dmVmOXNrSEpxK0k1?=
 =?utf-8?B?YU9VVVdlZXVKM2xETU0zNEVZVTRtdktmM3NiMlJISGptVmFPcWIxT1VGelJG?=
 =?utf-8?B?WDVieFV5TGtISnpDRVpOaElBaHY4ZlN3ZHFVUFpBRDdoWnQwTytXN0Z6ZUxJ?=
 =?utf-8?B?eStIK3NWL0w1TUJoZ1pmWFdqOHN6Zk4zWFpEU09WQXpxUis5NzYrOTBHdkZo?=
 =?utf-8?B?WTgrbytNREV4L0Y4eGJtTjNjbUlORFpYbzE1czlxY09yb002VTB4N0RrWnkx?=
 =?utf-8?B?VTc0eDVjR1MxMzI4bVRQMzZpa0RvcUZYUGM2SzBCWWFkcisrVU93TkFHdlRy?=
 =?utf-8?B?d0M4M3VzbWhvYWorU0FTd09hOFZ3NUpFaXkwV0NUd2FnbFM4VDRoSjlBMmNH?=
 =?utf-8?B?RFhodTlDZ0d0QnRIRkw0aFJGSjdwRmZwcU9uRis2TVAwQWIvb1lLZkkvSzEz?=
 =?utf-8?B?Q3U5RTJkU1A5TTU1cjBTMzJwOWFQWVl0ZE03TE1NdzQ0MkFHekdNa3B4WE03?=
 =?utf-8?B?S3ZyejBOZUFydjArZ0NRalFaNnRmRjB5VGNWMi80RldKbVE0NGp3N1NZbjlN?=
 =?utf-8?B?UUhodmFNRFlTNll4aG9WdXdNckx5L3R5Vi8vcUZqOHpPOEJ1UFpxdkJ0WXUx?=
 =?utf-8?B?b0NCZEIvNnhNMHNBcVlxYW5RZmZhRzFHYUlObDE1R0xaVUM1VUQxOUtzenVh?=
 =?utf-8?B?MkxWTWx5UVZTZS9YYVBNd2lpT0JTS0duTGg0aWpBNGlsQWtaSjBBbXpXaXNG?=
 =?utf-8?B?QUY0NHdvWEE5NDhKdGFhOVhjeGk4TEEra3BsTStYUDlpRnBCeEJVUlJpcGpu?=
 =?utf-8?B?MlBSb3lJTU4vVXdvdFpPamltSVA3RUJCMjB2SFRObTduRHZWRFB4Ui83Vkd5?=
 =?utf-8?B?TTIyMEIvNXJGWG9GU3VWZUhESFlaQkNVdzVKdkQ5MWliMG0xNnVjYXlRRXN1?=
 =?utf-8?B?YzB3dUVsQmVWY0s5S2djWFhIb0xXeUN0VUduOTNrVTJhL3BvOVp4WTZGNFVx?=
 =?utf-8?B?VkFaYXBwMWd1a3l0Vno4THpEd0FFaVJMalM4b0xvUEUyV20wcktUVGY2NTZa?=
 =?utf-8?B?VitMYWdtbFltSlAzRjdROEdxMGcwNnlFaTA4eEZVV3FxT0d5WFhQMklyV0JB?=
 =?utf-8?B?ZHVZcmZmdW93eGZjYnUvMisxZ2RZajcvamVSYXNJZHhTM25QNXJSWUNKcm9X?=
 =?utf-8?B?QU5XMk12ZTRVNVJxTjJKZWM3L2orK0NqRGdYY1JCY1lDbmlUM3lua080NnFI?=
 =?utf-8?B?d2orbnJpTHFlMTZGNUJzTzNDcGtlMDZoeEVUYkEzTVVDcnQ4YkJXVjVOMHVo?=
 =?utf-8?B?cnNuZmtXK2tsSTFjeTRZa0pua2lpcWtQYTREa1BnNHhQL3NoeDJKSkxkT24y?=
 =?utf-8?B?Rm5YY1UvVnVVTlhkNUpGcFN1NW5GejNlZXk0Z2l2ZnBwcitrOFVaUjVZUFVH?=
 =?utf-8?B?aHYzNlYxTlN3VWw2UWw2OGRIYWFPRlFXcWNyV09YdEVjdE9lb0k1Q3JYZVJo?=
 =?utf-8?B?dW5yWktpYXhMNXJaN0VXWG1TZitMVkhRVTJ0V25sRGxNaVFsYS9xbk1sSkFj?=
 =?utf-8?B?VW1qT3JWK1dlTFlNazF1VFB5alBRYWJBb091MGFoY3pWNGV3ejJ6dGlJK0w1?=
 =?utf-8?B?RlNYcEN0YXVua3pDbVVQWGxOOHFPemhZNm80VWY5TlpNSUIyNWowMGt1V3dY?=
 =?utf-8?B?QkVXamhNTEpDQWwxcE1velhpejQ3b0ZKQW9obEhWWElEMnJQOUJnK1AzUXlt?=
 =?utf-8?B?QXo5ZHJMa0VGYnZvV2o5azBaQ0ljZ1N5YTVwS1UzSDZXb2RUSFJFanJoM3Mx?=
 =?utf-8?Q?Ib3Le6?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(35042699022)(36860700013)(82310400026)(14060799003)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2025 14:48:02.1999
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48884d3b-a51d-40c0-49fe-08de1a1ed2eb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR08MB11643

VGhhbmtzLCBBcmQgZm9yIHRoZSBwcm9wb3NhbC4NCg0KV2Ugd2lsbCB3b3JrIG9uIHN1Ym1pdHRp
bmcgYXMgYSBDUiB0byB0aGUgRE1URiBTTUJJT1Mgd29ya2luZyBncm91cC4gSXQgd291bGQgYmUg
dmVyeSBoZWxwZnVsIGlmIHRoZXJlIGlzIGEgbm9ybWF0aXZlIHJlZmVyZW5jZSB0aGF0IGRlZmlu
ZXMgL2Nob3Nlbi9zbWJpb3MzLWVudHJ5cG9pbnQuDQoNClRoYW5rcywNCi0tU2FtZXINCg0KDQpb
MV0gaHR0cHM6Ly9naXRodWIuY29tL2RldmljZXRyZWUtb3JnL2RldmljZXRyZWUtc3BlY2lmaWNh
dGlvbi9yZWxlYXNlcy90YWcvdjAuNA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
IEZyb206IEFyZCBCaWVzaGV1dmVsIDxhcmRiQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwg
T2N0b2JlciAzMSwgMjAyNSA4OjI4IEFNDQo+IFRvOiBTYW1lciBFbC1IYWotTWFobW91ZCA8U2Ft
ZXIuRWwtSGFqLU1haG1vdWRAYXJtLmNvbT47IEpvc2UNCj4gTWFyaW5obyA8Sm9zZS5NYXJpbmhv
QGFybS5jb20+DQo+IENjOiBBZHJpYW5hIE5pY29sYWUgPGFkcmlhbmFAYXJpc3RhLmNvbT47IFJv
YiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+Ow0KPiBJbGlhcyBBcGFsb2RpbWFzIDxpbGlhcy5h
cGFsb2RpbWFzQGxpbmFyby5vcmc+OyBCb290IEFyY2hpdGVjdHVyZSBNYWlsbWFuDQo+IExpc3Qg
PGJvb3QtYXJjaGl0ZWN0dXJlQGxpc3RzLmxpbmFyby5vcmc+OyBsaW51eC1lZmkgPGxpbnV4LWVm
aUB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBvcGVuIGxpc3Q6T1BFTiBGSVJNV0FSRSBBTkQgRkxBVFRF
TkVEIERFVklDRSBUUkVFIEJJTkRJTkdTDQo+IDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47
IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+DQo+IFN1YmplY3Q6IFNNQklPUyBkaXNjb3Zl
cnkgZm9yIERUIHBsYXRmb3JtcyBib290aW5nIHdpdGhvdXQgRUZJDQo+DQo+IEwuUy4sDQo+DQo+
IEFkcmlhbmEgaXMgcHJvcG9zaW5nIFswXSBhIG1ldGhvZCBmb3IgRFQgYmFzZWQgcGxhdGZvcm1z
IHRoYXQgYm9vdA0KPiB3aXRob3V0IEVGSSB0byBleHBvc2UgdGhlIFNNQklPUyB0YWJsZXMgdmlh
IHRoZSAvY2hvc2VuIERUIG5vZGUuDQo+DQo+IFRoZXJlIGFwcGVhcnMgdG8gYmUgY29uc2Vuc3Vz
IGJldHdlZW4gdGhlIHN0YWtlaG9sZGVycyBpbiB0aGUgdS1ib290DQo+IGFuZCBsaW51eCBjb21t
dW5pdGllcyB0aGF0IHRoaXMgaXMgYSByZWFzb25hYmxlIHRoaW5nIHRvIGRvLCBhbmQgaXQNCj4g
bG9va3MgbGlrZSB0aGlzIGlzIGdvaW5nIHRvIGJlIGFkb3B0ZWQgc29vbi4NCj4NCj4gQWRyaWFu
YSBoYXMga2luZGx5IGFncmVlZCB0byBjb250cmlidXRpbmcgdGhlIHUtYm9vdCBzaWRlDQo+IGlt
cGxlbWVudGF0aW9uIGFzIHdlbGwsIHNvIGFsbCB0aGUgcGllY2VzIHdpbGwgYmUgdGhlcmUgaW4g
dGVybXMgb2YNCj4gY29kZS4NCj4NCj4gV2hhdCBpcyBsYWNraW5nIGlzIGEgY29udHJpYnV0aW9u
IHRvIHRoZSBETVRGIHNwZWMsIHdoaWNoIGN1cnJlbnRseQ0KPiBvbmx5IHBlcm1pdHMgdGhlIEVG
SSBjb25maWcgdGFibGUgbWV0aG9kIGZvciBub24teDg2IHN5c3RlbXMuIFNvIHNvbWUNCj4gd29y
ZGluZyBzaG91bGQgYmUgYWRkZWQgdG8gcGFyYWdyYXBoIDUuMi4yIChTTUJJT1MgMy45IFsxXSkN
Cj4NCj4gSXQgY3VycmVudGx5IHJlYWRzDQo+DQo+IE9uIG5vbi1VRUZJIHN5c3RlbXMsIHRoZSA2
NC1iaXQgU01CSU9TIEVudHJ5IFBvaW50IHN0cnVjdHVyZSBjYW4gYmUNCj4gbG9jYXRlZCBieSBh
cHBsaWNhdGlvbiBzb2Z0d2FyZSBieSBzZWFyY2hpbmcgZm9yIHRoZSBhbmNob3Itc3RyaW5nIG9u
DQo+IHBhcmFncmFwaCAoMTYtYnl0ZSkgYm91bmRhcmllcyB3aXRoaW4gdGhlIHBoeXNpY2FsIG1l
bW9yeSBhZGRyZXNzDQo+IHJhbmdlIDAwMEYwMDAwaCB0byAwMDBGRkZGRmguDQo+DQo+IEdpdmVu
IHRoYXQgdGhpcyBtYWtlcyBzZW5zZSBvbmx5IG9uIHg4NiBzeXN0ZW1zLCBJIHN1Z2dlc3Qgd2Ug
cmVwaHJhc2UNCj4gdGhpcyBhbG9uZyB0aGUgbGluZXMgb2YNCj4NCj4gT24gbm9uLVVFRkkgc3lz
dGVtcywgdGhlIDY0LWJpdCBTTUJJT1MgRW50cnkgUG9pbnQgc3RydWN0dXJlIGNhbiBiZQ0KPiBs
b2NhdGVkIGJ5IGFwcGxpY2F0aW9uIHNvZnR3YXJlDQo+IC0gb24geDg2IHN5c3RlbXMgb25seSwg
Ynkgc2VhcmNoaW5nIGZvciB0aGUgYW5jaG9yLXN0cmluZyBvbiBwYXJhZ3JhcGgNCj4gKDE2LWJ5
dGUpIGJvdW5kYXJpZXMgd2l0aGluIHRoZSBwaHlzaWNhbCBtZW1vcnkgYWRkcmVzcyByYW5nZQ0K
PiAwMDBGMDAwMGggdG8gMDAwRkZGRkZoLA0KPiAtIG9uIERUIGJhc2VkIHN5c3RlbXMsIGJ5IG9i
dGFpbmluZyB0aGUgcGh5c2ljYWwgbWVtb3J5IGFkZHJlc3Mgb2YgdGhlDQo+IHN0cnVjdHVyZSBm
cm9tIHRoZSAvY2hvc2VuL3NtYmlvczMtZW50cnlwb2ludCBwcm9wZXJ0eSBpbiB0aGUgZGV2aWNl
DQo+IHRyZWUuDQo+DQo+IE1heWJlIFJvYiBjYW4gc3VnZ2VzdCBhIG5vcm1hdGl2ZSByZWZlcmVu
Y2UgdG8gYmUgYWRkZWQgdG8gc2VjdGlvbiAyPw0KPg0KPiBUaGFua3MsDQo+IEFyZC4NCj4NCj4N
Cj4NCj4NCj4gWzBdDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DQUVSYm81ejZCekhx
UXhYZHhQeG14RV9lRFI3R0dHYnQzQThrQjANCj4gZ1FpV0ZCRS0yOFVnQG1haWwuZ21haWwuY29t
L1QvI3UNCj4gWzFdDQo+IGh0dHBzOi8vd3d3LmRtdGYub3JnL3NpdGVzL2RlZmF1bHQvZmlsZXMv
c3RhbmRhcmRzL2RvY3VtZW50cy9EU1AwMTM0XzMuDQo+IDkuMC5wZGYNCklNUE9SVEFOVCBOT1RJ
Q0U6IFRoZSBjb250ZW50cyBvZiB0aGlzIGVtYWlsIGFuZCBhbnkgYXR0YWNobWVudHMgYXJlIGNv
bmZpZGVudGlhbCBhbmQgbWF5IGFsc28gYmUgcHJpdmlsZWdlZC4gSWYgeW91IGFyZSBub3QgdGhl
IGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5
IGFuZCBkbyBub3QgZGlzY2xvc2UgdGhlIGNvbnRlbnRzIHRvIGFueSBvdGhlciBwZXJzb24sIHVz
ZSBpdCBmb3IgYW55IHB1cnBvc2UsIG9yIHN0b3JlIG9yIGNvcHkgdGhlIGluZm9ybWF0aW9uIGlu
IGFueSBtZWRpdW0uIFRoYW5rIHlvdS4NCg==

