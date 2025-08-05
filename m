Return-Path: <linux-efi+bounces-4513-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5932B1BA3B
	for <lists+linux-efi@lfdr.de>; Tue,  5 Aug 2025 20:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D0E18A5BCD
	for <lists+linux-efi@lfdr.de>; Tue,  5 Aug 2025 18:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A927629AAE9;
	Tue,  5 Aug 2025 18:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="C6rwklLy"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2090.outbound.protection.outlook.com [40.107.236.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B4629A307;
	Tue,  5 Aug 2025 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419024; cv=fail; b=VySbeA/Q9ktQjtKzicM8fS6H/D1MzKwJO9td8CWt4cy1CG7myMjyDz1uaDpTBbrEQYnV3tVAB9HYE65GyzdbWdVskiwD/vnJ+5dHdsSsyoiY/3Qknktiu4LYLRy8TPcb2RSCz0bdn9WJ2ZkS34f2f1MpkjUZ82MsnV7kir/XQ4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419024; c=relaxed/simple;
	bh=LlZZ0Gm00xCu5Lae6eN/LXpEBiAwLxBE9cvc3rBi8Ws=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=O5+YnDDWnO9yh4s+q4OKEFBZnFOMHfgSbiexH0wRBqyj+i6T036ykNtLAwwcYEC2lPNtblkBOT6/ECShXkodlev8x0dJi5LWp7I5g0nZERlYxpzKUiXnGCX+1b+AwqDw2ATv+mmvT1XQYoxkCQ4No9/ZoB6POo4lpfDgTrDsQX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=C6rwklLy; arc=fail smtp.client-ip=40.107.236.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPlpZeb5emK1Bk/gg5XFjGDQJikBIYZbPe0OCbS25Tq1xvCOAzP48GTfTLsbFK8Z3tqWClYtQpMyP0sioNw6R0IZxQkEX3Eqh42B/zW45Cgzdbcs+04jOqMW1WsERqKMzNPZY3ru9WN35HE78eejfR+B9BDz4RhXcXfypfzVOAFIKNHGwA4d/VuxXsyf58yjw5EfXNwBWyC/Da8QIoIJUxKg4oHXiZ9HmUu2r5SHrhLWX2tE7Kc3lR/yETcVURqvBhzPyb/5kA+9+qNVpAbd+tOV0dWnXTl45bIen5ikRHqZW3b56C3MKteS4juZ/v3X79p9NY0qcSrrD6NNgsiBmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5dTYyLO+c0RocfQ/gTdNVPVLsU4K+mEnn3DMqJxO1g=;
 b=Sr31Rs1gjkV01utxyY/ZXv78t6W48WsHGOWC9fHs1iY5Op/8j80vxn4dumFD0ULfjsdqfuLO1W1+FsL0XNi/2UZWa9YHrEj8Y3PIplCdqsb/ro6l6XGrtA2pBTLDn47aWb24VzuVnNLyvnqU5Er8t2jKAJeMIGGByKPqQDBsywqEAjkchRI90SzOHAe7znnsEmfrt3w+0owkvdDaGwFJtEgch1vsuct7Xndv7uMWJDxBzx5h+i1UEApevd47T4Y38nenFJJd4D6GzQoKml6/OOemWn0PDt6XFCFYaeiiZ9i7N7AoNYwibwnZGq8WyVbuMhlTwivvCP3gJqk/jYku/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5dTYyLO+c0RocfQ/gTdNVPVLsU4K+mEnn3DMqJxO1g=;
 b=C6rwklLyelvlEUAJ0Yx3I6sVCPZOWjKWPMMscQ9Z4/UXcylfoJ4DSA2oB17rapsyaGavtczwk4jeB9u8ULKYn7ZY8FLHA5A5FRVI8jfGv96swIsoDn1zcQVNbVTqacjo+Vtu7X0G810mE1ldXcC3rhyZIoywnTFvuxtrUj6QwCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 MN0PR01MB7755.prod.exchangelabs.com (2603:10b6:208:37e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Tue, 5 Aug 2025 18:36:59 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 18:36:59 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Date: Tue, 05 Aug 2025 11:35:39 -0700
Subject: [PATCH v4 2/5] efi/cper: Adjust infopfx size to accept an extra
 space
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250805-mauro_v3-v6-16-rev2-v4-2-ea538759841c@os.amperecomputing.com>
References: <20250805-mauro_v3-v6-16-rev2-v4-0-ea538759841c@os.amperecomputing.com>
In-Reply-To: <20250805-mauro_v3-v6-16-rev2-v4-0-ea538759841c@os.amperecomputing.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
 Borislav Petkov <bp@alien8.de>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-efi@vger.kernel.org, linux-edac@vger.kernel.org, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: CH0P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::24) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|MN0PR01MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: bcaf2b4e-0dbd-4f33-266a-08ddd44f0fea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXhRc1Q5THlTSzVic1JHSTJxYlVuK2ltNnptYmQ5c3JXNkdsejBLV1pFTUxh?=
 =?utf-8?B?Qkg1anFDOVN4ZE8vcGtzL3E4TmhaYVZYdUxFMWR4K1daL0htbW1GNXIvOTVv?=
 =?utf-8?B?S1hqb1RBRHA3eitabmlVSUM5bUpEV1pQVFpBeHVtdWNIQU9TMElNek9YblRY?=
 =?utf-8?B?bTVVc053ckVKNXFsZVNZVGZvWXNLcVEvVkl2WUZnMlNZbkc5cHh2dVBTbUFV?=
 =?utf-8?B?R1BmNXFmNWYwZWl3WXpXako2L0RSRXoyakpheW55UnJDQkVzamhlUkQvTDVv?=
 =?utf-8?B?akMxR0lRZ1RDKzd5UW9sM1NLRjgwMUIwcTJxZEorUmZMRytwL0hrVGFUVWJS?=
 =?utf-8?B?NkhHdndodTI0bCtQTXNudm1LelN5c1VWMXpXSTM0eDVaemRrL3llM3lvOURz?=
 =?utf-8?B?SlpwTEpSQTQ2QWgyOHRRbkM2ZXg0WnBBTnQwMUtIczZVVzRFY1RFSG52blFv?=
 =?utf-8?B?WnRKQW5GT3lJdVd5OXdxQzEzMmQwdi9HMHc0SnRsN2loeVlaelFkaWJNL2lO?=
 =?utf-8?B?MFNMYVBMWDc4RTZsNXQ3bzhSUnpoalNvRzg2NTJNOVJPL01JUlFpalMzWEpw?=
 =?utf-8?B?OXJlWGRCWGFRZ01TZmFPRFkvbGZPL3JERVdCTkVNYmZkdFo4SnNjS0lOQVpR?=
 =?utf-8?B?OFQwSWdvdXVyTTdOS3dFeHhIci9lTXQ5MTBjMkZUOFB2cE91WTlrc2YrU0Fz?=
 =?utf-8?B?bWwxZGhDOFNjNTVXOFhEZytBNXZ6QU96OXJsZDNacWNpc1k1MVVwTTZQRXd2?=
 =?utf-8?B?VTByaTJpR1dXbXI0OXlSdkxKSkNFOGp4THpGNVZyWEFkZmVIVzZZMGtFY3hR?=
 =?utf-8?B?eThlemxBblVmLzFYRVdwQmtvQ0JscmR3YTQ4VEsvRmhqZjhJU0JuV3BtY2dZ?=
 =?utf-8?B?SmhVdHI3blE0MEZuWmZIb3Z6OW82ZUxmb3lWbFRuNlBUVnd5bmdNb1BDRENu?=
 =?utf-8?B?VG4vSEgzQTBmYTJmNmtnWHlCcnJnOGJDYjJxK0dsK2pXMmQxazlIR0FlYXZG?=
 =?utf-8?B?UURsaXFpMHhGa1hneFhvbkdqRXNzVnBucFMrNlYxOEVEZUg0SDYvc1p1QjBs?=
 =?utf-8?B?NElBeUw3TGZURFdLcWlKTUJOT0N6MjF2Q3dXeTJhOHh0aURDc3Q0M2cvNnlk?=
 =?utf-8?B?WHAxWXE3SU5QQzY1dVBkSHlvN3ZQUXhlRnVLdXVXSjREZzdHZCs4WmV5bFV3?=
 =?utf-8?B?U21CejZta2tBWkJNbGdwUGllK3ZQajFScnA5c216V0ppb250L1FtV1lkeXBD?=
 =?utf-8?B?TllBYlZCWWZTVTFvbExlclV1U1FRbzdlWXZMMzRWcjhtd0J3anpPeGVqSDJk?=
 =?utf-8?B?KzRYWFdaRSt6bFphanN0TlhjYVgveG1jWUluR0UxdXloUkZOak0ycXp0SktC?=
 =?utf-8?B?b3dYRHEyakN3RW9FbWhvK0NYeDRWdDJmaUpDYzNYSi9XYXFEc1R1emlOR0gw?=
 =?utf-8?B?ekF2SHV1NDdIdDJSZzkvSk9VaXFIVlFoY0VSZ0p1cUhPRCsyNjgvYTROQ2do?=
 =?utf-8?B?MW15UWMwZG4yamIxb0IxZWp0S2ZmS3ZTb1VwYkIzaDZTVkcyQ3lpeDFOSXpM?=
 =?utf-8?B?UFpMMFJBdjh5Mi9BQlpQVm43dktNT3R0U055Y2kyOXZMYWpGUVBFYmcxTjZu?=
 =?utf-8?B?UEN6elYvYVFESFd0dk9qMjNzL3hkQ0F4WVE1dlVLcUx6WUUyQzZoZE1lOFVs?=
 =?utf-8?B?Q2tVcG5yUSszUnFYMG9jUzdDUkc3NXJQZHQrUDEvTVJMcUVlMEszNUpJQmlP?=
 =?utf-8?B?M0ExbEs3VVliM1J2eHBsdkhMMnB6a0tmOUZOT0lNVWpleEFQMnZtcGY3QWpH?=
 =?utf-8?B?RnRKOWV3dm90RU9NZ1VUa1NUQVBFN0FldjAzN0NsWXAzRVRZVzdhYjQxSm1m?=
 =?utf-8?B?bWxvVHBLaE0yTlY4QUFpL2FOYmdOeUNGUGFYZ0gwQ0g5UC8rdUMwZWhmVVIx?=
 =?utf-8?B?TE1BM0p2N1drN2tlYjdsMTNJcllCNDZTd2k4RHRVYlR0cTBMVU90S2RnaEpW?=
 =?utf-8?B?NHhPemFYVTR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmpsME5kWE9aNmJoOUEyQXVLT3BiTW1rQ3ErazFPYWRhRFRGV1Bpb3BhL2FI?=
 =?utf-8?B?VjNLK3FBUE4vb1hmVHprYkJkWnlUM2lsTDgzckJvd3RtaUdzVTh5UVgxd1hU?=
 =?utf-8?B?RUl4NTJzRnVtM3dIM0p6V21nZGxvNlR0d3hzaWk0WmdFRktwTU83aEZkKy93?=
 =?utf-8?B?MmNKWGtrcHoyT0JKVmwwczRIckxlYWNqT0Mrc3hmbUhDZDJkU3pnN1NQV1Rh?=
 =?utf-8?B?U0orbElib3hYWnBaaGhBb0t1VkduV2h0NnpSTGxFREJJbEN0cEh0OHVCcE9W?=
 =?utf-8?B?ZzVsQm5lRFQ2YWs2OXp5VW1zMzJkcDBna1JqRGYvWXhaT0hZQW4yYUw1alZT?=
 =?utf-8?B?VEtwQWZqS09rTVBjUjhNeW1vUGFlTitxQ3BITEcrUUlRSS8ram9ETk5ORjFT?=
 =?utf-8?B?QXZCVWdSNUhKLy9ZWVltaWYzY2JxbjVxdWNFVXA5NFFrTGF5bHVZanpSZGZl?=
 =?utf-8?B?OE1Zd3dva0MvN3JJVWdSUzJVLzdxSkNoa296S0lRRytGTUc4SWJablA5c0Y2?=
 =?utf-8?B?QUZ5WkVhZlZ0UnB6Nm55ZG5uSGluWG5aWGpqellMZDNseDRiTFduUER5ajlX?=
 =?utf-8?B?cUQ0OU9HOEFQdFFLUVExbVZHSzRFRnZJdSt3VGNzNnYwb2FIUnErbXUxMGpj?=
 =?utf-8?B?SDkvTkcybVd6Z1NZcGdlaXBxV2sydUM2Y01EdEl2VExVdGdlSVVQUWEwSC84?=
 =?utf-8?B?MDNVem42c0ZLa0dVOEFpWFd2dk92TE5Zd0VFeDFRUnRNMHhVZmJmOHZrK1Fu?=
 =?utf-8?B?Z1ZaZkljaGczbHlPT2t1bFJaZUtOamNQdEpmK1d6OHphRXVGbkxTc09uOHZo?=
 =?utf-8?B?TThKbUdsMkVaVGtuR2FsaHdjNnA1ZmU4ZWRyVGRSbDQyQVBsbTQxYWZveWhR?=
 =?utf-8?B?eUhicEd3OFdLYk5vVVdVanRIRFJGb0JIWEU3bFMvOFNVWEp6QUtlRTRUMUlM?=
 =?utf-8?B?eWp6YVhla09PeE1MRlZZSW9oRTE0c1hIdldDUHlqYTJCWHNZRVBOMXZ3Mmp2?=
 =?utf-8?B?ZEJ6dFMzT09HWEprM3dkK21vSEpySG11WUNjK3JEdDA2S2xJcytEUk1COGpt?=
 =?utf-8?B?bGphd0piNThvOEttQ1R4RWZkVEJRMGdvVzFrRW4yRnF0NGNuV3ovdFBDcldD?=
 =?utf-8?B?bTlVZW4zMWNhSHR6c05uVjk0ZUZQSjEyaStUNkhCVDBOVFE3RlJVcDZqaWYy?=
 =?utf-8?B?ck10WjVPUk8wd2NYSDJXdml2aVVJcFkwNlFBbUt3MU5YTUZpSEk1MFpTR0tv?=
 =?utf-8?B?d3MwMmVqZythT0tZSmtlemI2Q200dEo0QVZmbSs2bzlqd0FuTXI3UW9GZDRN?=
 =?utf-8?B?Qmx1U09YSFM2UlMyM2VyaXkxa2lwdG9zQnpqWXZvekF1ZlV1MXhkbEJtOUtu?=
 =?utf-8?B?a25aWEErdUJTdDJheTREQUYwSCtrRHRsWHE4MXpVeXQyeTg0KzN5QllnU0t1?=
 =?utf-8?B?ck5jR0pMZG1IS0lDa3YxVFVLNEIrN1VuS0RkMVg5NzIyVVRpY1l0QmMxRUNU?=
 =?utf-8?B?N1I1cHhCcUpKVXIwZC9LcDZHeUNzS3hMZVlTZ2pLSENKVkh0M3VUSWdUM1lr?=
 =?utf-8?B?cFM4Qkh5UmNWQnpIbjVsa2NhUGpJcDdDbnNUSE1VY3FUOHUzNmREYmlQWis2?=
 =?utf-8?B?d3cxaUVuYk12U0REK0RSVTdmbzN2dElsZVA1V3pZcUhlSHdBMlRoRHNGdUpU?=
 =?utf-8?B?YWdkS0ZXeUJ0cjFoSTBtS1d6ZFphbEFHTjY3Mmk0Yk8zcXlHZTZzc3hOb1pI?=
 =?utf-8?B?Y1ErN3U2aVFtKzNHa2RjQnpnSzhXL1EwN2VXSzBQOURqWEdDKzFhZjhwR256?=
 =?utf-8?B?TmlhUDJFMnp4MFI3RnJic2U1VXJqTjc0NWlPVGhmc1crMVJOakROaWY3dVhE?=
 =?utf-8?B?TFNvWi9mVFZ6NVhzVXBXalAyUkJtVUtPSmQyWERocXZRNjBDeDc3NmZwOWtS?=
 =?utf-8?B?d21tRUxiVUdBYmZaeWc4MGMxNWFDU1ovTTYzcUlVVjMwR0ZLOVZNRHBEQTg0?=
 =?utf-8?B?Z2M5MGJQUURxWkJ4STVFbEg4UG5oVkMxYVZXUjIrWFFUNzJSRkdzaVB6ZlN0?=
 =?utf-8?B?cDR5a0pic2Nta1FpTnkrK0I1L1ZoY1R4Wm5QUXpzdFhxdEplYkN4VU5aOVhx?=
 =?utf-8?B?MjMvalJzL2NiR004M1JHT0hIbWUvOTVEcTBQMWU4K0ErTXlBL013RVJsTE9B?=
 =?utf-8?Q?wuCZ7zgn/KeQgi+U83N0uJU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcaf2b4e-0dbd-4f33-266a-08ddd44f0fea
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 18:36:59.2408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmOkFGdow9tFxRhwLMMFQArx8lG/fSvIR/sUsYUEWBr1o7EmGIjTT5ICD0n7AaQku6St8UjlaEFEflUgAmFfbNiDqUbLsqVbh34T3scJ9XazZHGIQ8g4UyFS70xLcaJV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7755

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Compiling with W=1 with werror enabled produces an error:

drivers/firmware/efi/cper-arm.c: In function ‘cper_print_proc_arm’:
drivers/firmware/efi/cper-arm.c:298:64: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
  298 |                         snprintf(infopfx, sizeof(infopfx), "%s ", newpfx);
      |                                                                ^
drivers/firmware/efi/cper-arm.c:298:25: note: ‘snprintf’ output between 2 and 65 bytes into a destination of size 64
  298 |                         snprintf(infopfx, sizeof(infopfx), "%s ", newpfx);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As the logic there adds an space at the end of infopx buffer.
Add an extra space to avoid such warning.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 drivers/firmware/efi/cper-arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
index f0a63d09d3c499b2f1e51d5ef35b69deeb3cbdb3..6ff781e47147c05c784ca5aa57149d1435cb2467 100644
--- a/drivers/firmware/efi/cper-arm.c
+++ b/drivers/firmware/efi/cper-arm.c
@@ -240,7 +240,7 @@ void cper_print_proc_arm(const char *pfx,
 	int i, len, max_ctx_type;
 	struct cper_arm_err_info *err_info;
 	struct cper_arm_ctx_info *ctx_info;
-	char newpfx[64], infopfx[64];
+	char newpfx[64], infopfx[ARRAY_SIZE(newpfx) + 1];
 
 	printk("%sMIDR: 0x%016llx\n", pfx, proc->midr);
 

-- 
2.50.0


