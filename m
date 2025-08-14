Return-Path: <linux-efi+bounces-4557-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43186B26D1E
	for <lists+linux-efi@lfdr.de>; Thu, 14 Aug 2025 18:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89308603A6D
	for <lists+linux-efi@lfdr.de>; Thu, 14 Aug 2025 16:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8503002B7;
	Thu, 14 Aug 2025 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="hY0ZR+8F"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2136.outbound.protection.outlook.com [40.107.94.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0882E2FCBE7;
	Thu, 14 Aug 2025 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190397; cv=fail; b=ksdzDnJuVEEUjld5zLgVQeH9qnFQcu3TLE8jhj+QOZmpkzXkdg8MN9yAR0x8N9RTF2vWfWGsBX/K8SlsXeBcpBpjezSlclsVTfv5q4iEd+2F/+bXoy91RktX+geLe+H2UvK231u1qKhpKOkCYLxk/PDkN8uoNLMpCBfZc9E1gik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190397; c=relaxed/simple;
	bh=W9uCxRmXFi4I4ZipftyIxfEBg9sBVDNykOu0JSV8rGE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RRnzbe6cstb45N18H4Jt4GVIqDoLJD/51oHPS45cJ70S0VAkLn/N0qFLb8ebnehxhNIOx8igUh11yxBaprpZIi9dwYv8/OFhGUaNQOpXgykq43asxKTih2dFL+O8II/v7+h8DFLGKRhE4gT1AAYBbd38We6DxKf75cNSy/LY+CA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=hY0ZR+8F; arc=fail smtp.client-ip=40.107.94.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhMFIfIMXZfRvolJZdEGzitMcoloda7gXVZI/LlFhiBT/HMcWbTM1dZ0sE+i9B9ZTQeXeOgZ3l+L2eVmc96ZK5W1K83dOLjB2agfSaKh2jJVkkV8LuuDXPhYukiNILKS9ll3Hy18bzZykL5IF5EcrDu+issRSL/eof+1FijgUz5QEJS4uSFlyP7TPfYT7KoTzCO6xteAnU5bG7ec/kyEHUDNoaX5mhRdMwPl8tVc4temU7+89Bvyyo0JYhObV3OofTd6RCUgT0ucs5zW9VeQe6co9H2Hp8DcXBFtC/AhDMI8WxbbwZHcwHFVajW4/koyB8Bi/30ZziPTNA850IzfRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDPdh5/KZZhUE9C8eI1j3GemRKaQ4CISdV05oe41s8o=;
 b=VekdtT8cASyiOWcGaWrKP4yxSkyrmwOGmJ0gYwYoKPAFMwv2AMD+5ckOGGM0e2H2/aE1fG/9C5Nf6Z6xj4hUMiMqYwxEQxmnBSbZKRHOGaD0nqsihUqm0uFuWSLCNhY7gYiryO6Xh/Xy8/n3h/+U3RcpnlNh6Gaob7WBeVS7NfQBovOKMLmMk8aj/+nvnNpQ6X1MX0DboZ8pynxw36ksXKZVIgofXp9RBUPfLdED0JuroJg9He+tazo/Y6z9w0wGMrCCDH+N3m+ynpgLaepLEtf0lOjhJR82sNKikC3YxCBNR0gg4lftzaz5tKe8C0FCKUEwVYUMHmpOMNpVwm5XQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDPdh5/KZZhUE9C8eI1j3GemRKaQ4CISdV05oe41s8o=;
 b=hY0ZR+8Fk+B5Sr8MdKUA366rtFcfttxyHKyNcLcBx0PNWJIdlqbrNJ2VOz4pjeNwHss2ZkH1IOdAeDAK1ggigls4+nsrpvRFVAdczeF0DS7lifkEtaTSFdYiXUIqRRW1G8g0bVnoopjz8a0gDtOlmwpcXbSVruZkG0GvQ9efH2w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 BL3PR01MB6881.prod.exchangelabs.com (2603:10b6:208:354::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.18; Thu, 14 Aug 2025 16:53:13 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 16:53:12 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Date: Thu, 14 Aug 2025 09:52:55 -0700
Subject: [PATCH v6 4/5] efi/cper: align ARM CPER type with UEFI 2.9A/2.10
 specs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-mauro_v3-v6-16-rev2-v6-4-e5538d534aa0@os.amperecomputing.com>
References: <20250814-mauro_v3-v6-16-rev2-v6-0-e5538d534aa0@os.amperecomputing.com>
In-Reply-To: <20250814-mauro_v3-v6-16-rev2-v6-0-e5538d534aa0@os.amperecomputing.com>
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
X-ClientProxiedBy: CH2PR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:610:4e::40) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|BL3PR01MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: abcace19-59c4-4478-205d-08dddb530e57
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVJBUkVRd0JndngzMitDTThUU0VybnJmekYzVWZLTWgrMURQUTFRRDZDeHJU?=
 =?utf-8?B?Y0cvQjlHRGQvTnE1U2QvNzJEZHVHdlBHM1VIWHc5ZEMrdGlvd1prMUEvV1U1?=
 =?utf-8?B?OVc0eEl4TnVaQktCQmFvbHhvQ2ZTa3pHMVA5SEFzWFMvdURLT0lyb1dSbjYz?=
 =?utf-8?B?L1UwOHFtK1B3d2pHQ3FHakh5TGxLZmMvZktpcCt3QXdhdXU2ZmI1RENKR3hW?=
 =?utf-8?B?ZDcrSHZmY0VTR1dJU2U5S01yY25SZ09uV3FnbHVwQUtkTFdlYkNIRFNBZEZH?=
 =?utf-8?B?Q2NkNkNXVkF1TklqckdCWXRPc1lOeis1bko3STZaMk5ac1RxRTFBejVZc0JR?=
 =?utf-8?B?d0ZnKzU4OWxuSkZFNS9kQU02dzNJcjhYT3N2UCtyeUdWcVl5Z0RuNUpxUVdR?=
 =?utf-8?B?MmN5Wnh3NGp0bDlYMUU0SzdBR1NGUmk0VHRBYmpycXhFcCtaYlU4c1lnT3Ix?=
 =?utf-8?B?QWZERWh5bGJKM2RsaS9HNFNxUWptbUh5TUNFZzAzRlBqbTdBSnNHRzVCZHBM?=
 =?utf-8?B?TkljcXpWcFJWcVFnSGFWRE1CdzlUVml0TXI2NDNLSmtGZDZqazlHdnVIdjY1?=
 =?utf-8?B?U2N6OFpDcnIxcWptVVFKbUJlQmd6akZ5RE9tcHNSdFlwSDMwa2NDSE9hb0p3?=
 =?utf-8?B?bVErMXRxbVorQTc4TUxUWHIvMkNlSUlpeW8xeWU1UTRoM1FoMm9JOGhkTmk2?=
 =?utf-8?B?MFZOdVQrd3VsdTB3eDBmSVR5Nm45UURIb1BIbFVjNnhLd09raVBSQ1Y2QklQ?=
 =?utf-8?B?YzVOWkZqazFPWG5PV2Z4ZStENW11c0ZXS2Zvb0JCYWJPN1BJVWp3RmxWTnl2?=
 =?utf-8?B?d1Y3clFxVUpsbzN6NWRpTkV4eThjY1lEMTZWb0VjZXNkaElEUlFHZEl4TjZT?=
 =?utf-8?B?cXNIK0NTbXdzUW5XN25GVEhRbWRYNTBERndjblR6cmk4ckM5RjVMeTRhSWdB?=
 =?utf-8?B?cFdsMW1xcTkrRnVFVitmVk1rNmxKdWdCWklpUXgxYXlONjFrZWVRYVo0M1Mx?=
 =?utf-8?B?NUY0dFRvbnJUakcxS2pqZGd4UEtzd0JKbGt5OWo1d0VpaUp4Q1pwMUpHcWlu?=
 =?utf-8?B?Z2JLUXlQNlZSS012R1JjNHl2WGtnQ0Z1aFgzRTRNVjFYMzdiejh6dWJpOFJt?=
 =?utf-8?B?b2J2TWNsVTBXdGFzZEZJL1JacGZibVhZdmNaRjRXK0FFeElqd05Wd2NqSWFG?=
 =?utf-8?B?a3VRNktLV05ZUk9MZWt6V1FVY3daNit6YW5HcHVDd1Jnb2xvYVVnRmQ4NFpS?=
 =?utf-8?B?cFNIQXIvSDJTU1NGSkc5dXAwM3lTZ2hiNGdoclc1WXFCZklVQ0xKNnlZdHVB?=
 =?utf-8?B?bE84QUFDMklpVVBIdklyeldETXBGd3RnRFVLSnJhbXo5WU5Qa25RS3FhcUtn?=
 =?utf-8?B?QkpKMWd5Tkc1dnNsbS84SXBUYmM4YVV5dmY0aFpVOVF3a2VSRk14V3hSUmJi?=
 =?utf-8?B?M2QyeEo1K1RRZ2FnL2FQUEJtS0tZUDkwKzU3K1BvWnRxVHQzR1M3NWkyUVN6?=
 =?utf-8?B?WkR6R3F0d2tVb1JmazFwMjhuYzhob0FlZWVlN2RLU0NyUjdPdk5iWmNNWk9I?=
 =?utf-8?B?RTFDZSs4WjVhMlowVS8xRlkwMVdaN2gyV3ozRjVpajF4aUc5ZFJZaHFFTWI1?=
 =?utf-8?B?SU5BVWw5RnNYUDBGSnlVVkZOb2xHYms2NDBFd3VpaGhIT2VSbXJQTGZodnk0?=
 =?utf-8?B?UGRKYjFzS0JzakhjY3ZUNFRGTDBzSEFKTXE2MEFPVFF0MEptVi9uWlZHQ2JF?=
 =?utf-8?B?enI3bEVmd1RPNllZS0Jsem00TkhTZk1VaXF6NDFpdG4wQ0FwL3JnaHAzWmRZ?=
 =?utf-8?B?WFlWM2F4RzBwQWhTamhBSlFXRjBJaStZeTZqUmZScDc2dUs0S1lmYXVWWVU1?=
 =?utf-8?B?cUJqbGRXMFNOeFBueWV4OXdMUFg3NkhFcWZ5Rmc2c3lLMkk4WWlEWC9kQmlw?=
 =?utf-8?Q?UVBuSwZHJDE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0JwbU8ySHpzNW1HM0VwRXNKLzZvc2RhblQrdU1ra0diY29VQldBZzh0Mi9z?=
 =?utf-8?B?STVPdE9wWEVqZGcvdGo2R3pGWHhSeDZuYWpGam1EbXFJVnozYk9naG5qeWtM?=
 =?utf-8?B?cHBBYll0aFZsMGR3R2h6N2c4ZkFJV29PVXlSNFpMN1NoMCtqTVl2Y1pjdzhO?=
 =?utf-8?B?ZFZnNkNHUEFFMFovYVIrMTZpK3B6UTA2a3BoL1AvT0wvQ2lobTJ5a2RTeUVs?=
 =?utf-8?B?OG5GSUovcmp0SGx6bHhCazMvRDBzQ2tiYXdMbjM3R1hkV3JtQk5MQUhwVWRB?=
 =?utf-8?B?S1h5R1FkcTlBVHBlZDBsbEtLbzRNT3FQcTdFNWhTMFdDMzE4Sm1TMjJQMThG?=
 =?utf-8?B?VGp4Mnk0eGtDUy9HZ250WmtZcWNnNWdERm1TUlc3R2lTbDFQR2NJeUFIQUpt?=
 =?utf-8?B?bHNWaWU0OFZQbXRZcmZneldiSGJCcGR6dTExRUN6UmdkcWFpYWRkUVV0NmND?=
 =?utf-8?B?NUxGMkhUNGdiL2k4WWFRMzQrK2YzQXk1dUw4QlpjcjNBempLWTRJNVJPcENq?=
 =?utf-8?B?aGZjLzI1V1dDaVB1b2tVekJGQzFiNnNtMVR5VHJNOUNzWW02UXh1TFFlTm5N?=
 =?utf-8?B?S2NPYnJBTVhjQUM3UU1SNmdTRnNDL1ZyRjhUY1k4MkhZUjVtOXVJaHJVQzVi?=
 =?utf-8?B?V3VNZG9seHNyRllZK3BpUlE1L2RObWZBYkUrTUtBYU9iV29ncjF1aEZNaTdJ?=
 =?utf-8?B?SVBPZ3NtdmxqeDhiYVU4QnBJSGJpTFNaNVBoWU55c3BwRER4QWNwNkx1aGtk?=
 =?utf-8?B?ZE5WM3NCaFR1bmNPZHpXQWRwdTVBYUdsWmFNRkVuRUxkRDRrWnp4Z1l0dWhR?=
 =?utf-8?B?dXNGWnpuejhQd2FsVVQ2b3IzODNCQ2F2QzZBdWN5aVpTekY5RlpzZWhRV3ox?=
 =?utf-8?B?R3diYnJaV3lwWmtIblE3MHM5S2tVSVNFYTZxRUh2elllUktkSUhLdGcvbUFZ?=
 =?utf-8?B?ZkRQSWdrcmpVNVFTeFNXdmtlcUIzVmd1b2VJUEhzcUVVbFBqMXN3RUNhZDBw?=
 =?utf-8?B?TnBZWnBrVlMvYyt2c1Rpd0J5MWtWOTBRejdxb3VQdkMveDVXazlHU05BN1Ix?=
 =?utf-8?B?eDVQNitzRHJCUXc2bk5kUXZpS0RXdndQck42VXg3OXprYkJPRHlMQ25zNzNU?=
 =?utf-8?B?VXdyc0lxYUJhRU85c1Z0MW12d2NXOU45SUxVM2NSb1BtVWMzbUtIVldJZmpI?=
 =?utf-8?B?S3NYYVBCa1A0eit5OE5FYXkvbExZdTdPeStwcmNWdEJmL1VJeEpGNzNXZjNN?=
 =?utf-8?B?VTJaNUFHY3lIRk9WWldtazhHSEVEeGg2cFMzbklNY2lIT2dlUk94WEk4Y29t?=
 =?utf-8?B?R3RhemhRRUg2bm55YU5GVWJxeW56eWNNOXBPcVNJcW1DOHJJTkg3V1c4cUNI?=
 =?utf-8?B?VUFFRWFkZVVtNWRYVnVNN04vRWcvL3M2RjdLc3IxVEFwQjU3VUtTbXNpQ09J?=
 =?utf-8?B?VGhtVlhvcU03WStHN2ozaTNCZjZJcUZJVXpHdHF6dmJQL3FseUtmNFpya2Ni?=
 =?utf-8?B?TXVxYkkwZkZ5VzJlRjJlajB0eExnamwwSXRxeFIyQ2VsdTQwd1FWTjl2eHRy?=
 =?utf-8?B?bytlZi9sYTR6MWlLOHIrazQ4d0xNd0FJV0ZVeE02ZmVMUWNVNElZMnZCV3Z2?=
 =?utf-8?B?ZytNVXZJeXlKS3JKcnFQVUROUzFScWNUbVFRU3hibWY2Q2hzSUtzZldNYXI5?=
 =?utf-8?B?eHlzUlpQVC9ZUWhpeitkTE1TM2luWjUrRldIRzQ1SlVVemNYRS82OEVHUXJL?=
 =?utf-8?B?MmlHblVic3RSQUlMeDJyaUwvMGRWaVFXQm5vaFZrUUtjZTUzSU5CbG1UN25o?=
 =?utf-8?B?elZPb0hNTUtkK2Nyc09YUy8wVkFJKzYxazh1bkphYkp6U3FUcEJmbTFzakk5?=
 =?utf-8?B?VTdIUURwMGdyWE9wWUVrekxYamhnTlJ1TXhYdHdUOWpaeUZ6QVRtTitkMWQr?=
 =?utf-8?B?cTE3OHptOExkN3Z5UUxDdFZmMjdTN0pOV1l6L3BydnV3NG91ZGVpbTdSRkhs?=
 =?utf-8?B?Qzd3VWg2TlJBMWtUNEpsOWVPRVhmbkZFRUZuUHlBM2RjTFdXTm5iQzVOY3hI?=
 =?utf-8?B?YVdEdk5vQU1JVEdTb0FJbzJjcUJxQWFIb1V2RTRRUGE0bC9zYisrQUQ1eU93?=
 =?utf-8?B?RThhUnU2VGxZek9QcUpzNXJjYWhZLy85aWk4R0g1ZXpmSEtybjc3Um9PSWVI?=
 =?utf-8?Q?OV6s3ia7Ep4DpS+lDVB0lH8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abcace19-59c4-4478-205d-08dddb530e57
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 16:53:12.7194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fpy25IkkCpAGXtZzywApmp3TXMFcVxBXugR9kjefRRKkn6UZ3StWQBTjCY61M099UpnA6ukFVzzoqX+Z+tdQqH9hUqCtoOGJaxVBg+7Q1fRC8GAGaRpaU0ZZz7t+/UiT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6881

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Up to UEFI spec 2.9, the type byte of CPER struct for ARM processor
was defined simply as:

Type at byte offset 4:

	- Cache error
	- TLB Error
	- Bus Error
	- Micro-architectural Error
	All other values are reserved

Yet, there was no information about how this would be encoded.

Spec 2.9A errata corrected it by defining:

	- Bit 1 - Cache Error
	- Bit 2 - TLB Error
	- Bit 3 - Bus Error
	- Bit 4 - Micro-architectural Error
	All other values are reserved

That actually aligns with the values already defined on older
versions at N.2.4.1. Generic Processor Error Section.

Spec 2.10 also preserve the same encoding as 2.9A.

Adjust CPER and GHES handling code for both generic and ARM
processors to properly handle UEFI 2.9A and 2.10 encoding.

Link: https://uefi.org/specs/UEFI/2.10/Apx_N_Common_Platform_Error_Record.html#arm-processor-error-information
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 drivers/acpi/apei/ghes.c        | 16 ++++++++-----
 drivers/firmware/efi/cper-arm.c | 50 ++++++++++++++++++++---------------------
 include/linux/cper.h            | 10 ++++-----
 3 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 99e25553fc1320b2306efb751e12f2377c86878a..79a128cb04c351c1d01ee749904ee844963d0f10 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -22,6 +22,7 @@
 #include <linux/moduleparam.h>
 #include <linux/init.h>
 #include <linux/acpi.h>
+#include <linux/bitfield.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/timer.h>
@@ -531,6 +532,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 {
 	struct cper_sec_proc_arm *err = acpi_hest_get_payload(gdata);
 	int flags = sync ? MF_ACTION_REQUIRED : 0;
+	char error_type[120];
 	bool queued = false;
 	int sec_sev, i;
 	char *p;
@@ -543,9 +545,8 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 	p = (char *)(err + 1);
 	for (i = 0; i < err->err_info_num; i++) {
 		struct cper_arm_err_info *err_info = (struct cper_arm_err_info *)p;
-		bool is_cache = (err_info->type == CPER_ARM_CACHE_ERROR);
+		bool is_cache = err_info->type & CPER_ARM_CACHE_ERROR;
 		bool has_pa = (err_info->validation_bits & CPER_ARM_INFO_VALID_PHYSICAL_ADDR);
-		const char *error_type = "unknown error";
 
 		/*
 		 * The field (err_info->error_info & BIT(26)) is fixed to set to
@@ -559,12 +560,15 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 			continue;
 		}
 
-		if (err_info->type < ARRAY_SIZE(cper_proc_error_type_strs))
-			error_type = cper_proc_error_type_strs[err_info->type];
+		cper_bits_to_str(error_type, sizeof(error_type),
+				 FIELD_GET(CPER_ARM_ERR_TYPE_MASK, err_info->type),
+				 cper_proc_error_type_strs,
+				 ARRAY_SIZE(cper_proc_error_type_strs));
 
 		pr_warn_ratelimited(FW_WARN GHES_PFX
-				    "Unhandled processor error type: %s\n",
-				    error_type);
+				    "Unhandled processor error type 0x%02x: %s%s\n",
+				    err_info->type, error_type,
+				    (err_info->type & ~CPER_ARM_ERR_TYPE_MASK) ? " with reserved bit(s)" : "");
 		p += err_info->length;
 	}
 
diff --git a/drivers/firmware/efi/cper-arm.c b/drivers/firmware/efi/cper-arm.c
index 6ff781e47147c05c784ca5aa57149d1435cb2467..76542a53e20275cf0f059e9ce409fd898de16d4d 100644
--- a/drivers/firmware/efi/cper-arm.c
+++ b/drivers/firmware/efi/cper-arm.c
@@ -93,15 +93,11 @@ static void cper_print_arm_err_info(const char *pfx, u32 type,
 	bool proc_context_corrupt, corrected, precise_pc, restartable_pc;
 	bool time_out, access_mode;
 
-	/* If the type is unknown, bail. */
-	if (type > CPER_ARM_MAX_TYPE)
-		return;
-
 	/*
 	 * Vendor type errors have error information values that are vendor
 	 * specific.
 	 */
-	if (type == CPER_ARM_VENDOR_ERROR)
+	if (type & CPER_ARM_VENDOR_ERROR)
 		return;
 
 	if (error_info & CPER_ARM_ERR_VALID_TRANSACTION_TYPE) {
@@ -116,43 +112,38 @@ static void cper_print_arm_err_info(const char *pfx, u32 type,
 	if (error_info & CPER_ARM_ERR_VALID_OPERATION_TYPE) {
 		op_type = ((error_info >> CPER_ARM_ERR_OPERATION_SHIFT)
 			   & CPER_ARM_ERR_OPERATION_MASK);
-		switch (type) {
-		case CPER_ARM_CACHE_ERROR:
+		if (type & CPER_ARM_CACHE_ERROR) {
 			if (op_type < ARRAY_SIZE(arm_cache_err_op_strs)) {
-				printk("%soperation type: %s\n", pfx,
+				printk("%scache error, operation type: %s\n", pfx,
 				       arm_cache_err_op_strs[op_type]);
 			}
-			break;
-		case CPER_ARM_TLB_ERROR:
+		}
+		if (type & CPER_ARM_TLB_ERROR) {
 			if (op_type < ARRAY_SIZE(arm_tlb_err_op_strs)) {
-				printk("%soperation type: %s\n", pfx,
+				printk("%sTLB error, operation type: %s\n", pfx,
 				       arm_tlb_err_op_strs[op_type]);
 			}
-			break;
-		case CPER_ARM_BUS_ERROR:
+		}
+		if (type & CPER_ARM_BUS_ERROR) {
 			if (op_type < ARRAY_SIZE(arm_bus_err_op_strs)) {
-				printk("%soperation type: %s\n", pfx,
+				printk("%sbus error, operation type: %s\n", pfx,
 				       arm_bus_err_op_strs[op_type]);
 			}
-			break;
 		}
 	}
 
 	if (error_info & CPER_ARM_ERR_VALID_LEVEL) {
 		level = ((error_info >> CPER_ARM_ERR_LEVEL_SHIFT)
 			 & CPER_ARM_ERR_LEVEL_MASK);
-		switch (type) {
-		case CPER_ARM_CACHE_ERROR:
+		if (type & CPER_ARM_CACHE_ERROR)
 			printk("%scache level: %d\n", pfx, level);
-			break;
-		case CPER_ARM_TLB_ERROR:
+
+		if (type & CPER_ARM_TLB_ERROR)
 			printk("%sTLB level: %d\n", pfx, level);
-			break;
-		case CPER_ARM_BUS_ERROR:
+
+		if (type & CPER_ARM_BUS_ERROR)
 			printk("%saffinity level at which the bus error occurred: %d\n",
 			       pfx, level);
-			break;
-		}
 	}
 
 	if (error_info & CPER_ARM_ERR_VALID_PROC_CONTEXT_CORRUPT) {
@@ -241,6 +232,7 @@ void cper_print_proc_arm(const char *pfx,
 	struct cper_arm_err_info *err_info;
 	struct cper_arm_ctx_info *ctx_info;
 	char newpfx[64], infopfx[ARRAY_SIZE(newpfx) + 1];
+	char error_type[120];
 
 	printk("%sMIDR: 0x%016llx\n", pfx, proc->midr);
 
@@ -289,9 +281,15 @@ void cper_print_proc_arm(const char *pfx,
 				       newpfx);
 		}
 
-		printk("%serror_type: %d, %s\n", newpfx, err_info->type,
-			err_info->type < ARRAY_SIZE(cper_proc_error_type_strs) ?
-			cper_proc_error_type_strs[err_info->type] : "unknown");
+		cper_bits_to_str(error_type, sizeof(error_type),
+				 FIELD_GET(CPER_ARM_ERR_TYPE_MASK, err_info->type),
+				 cper_proc_error_type_strs,
+				 ARRAY_SIZE(cper_proc_error_type_strs));
+
+		printk("%serror_type: 0x%02x: %s%s\n", newpfx, err_info->type,
+		       error_type,
+		       (err_info->type & ~CPER_ARM_ERR_TYPE_MASK) ? " with reserved bit(s)" : "");
+
 		if (err_info->validation_bits & CPER_ARM_INFO_VALID_ERR_INFO) {
 			printk("%serror_info: 0x%016llx\n", newpfx,
 			       err_info->error_info);
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 58f40477c824e61c7f798978947bf1f441ce45ad..5b1236d8c65bb7d285a327c457115a18fc9d7953 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -297,11 +297,11 @@ enum {
 #define CPER_ARM_INFO_FLAGS_PROPAGATED		BIT(2)
 #define CPER_ARM_INFO_FLAGS_OVERFLOW		BIT(3)
 
-#define CPER_ARM_CACHE_ERROR			0
-#define CPER_ARM_TLB_ERROR			1
-#define CPER_ARM_BUS_ERROR			2
-#define CPER_ARM_VENDOR_ERROR			3
-#define CPER_ARM_MAX_TYPE			CPER_ARM_VENDOR_ERROR
+#define CPER_ARM_ERR_TYPE_MASK			GENMASK(4,1)
+#define CPER_ARM_CACHE_ERROR			BIT(1)
+#define CPER_ARM_TLB_ERROR			BIT(2)
+#define CPER_ARM_BUS_ERROR			BIT(3)
+#define CPER_ARM_VENDOR_ERROR			BIT(4)
 
 #define CPER_ARM_ERR_VALID_TRANSACTION_TYPE	BIT(0)
 #define CPER_ARM_ERR_VALID_OPERATION_TYPE	BIT(1)

-- 
2.50.0


