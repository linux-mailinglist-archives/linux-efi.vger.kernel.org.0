Return-Path: <linux-efi+bounces-4546-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AD1B25523
	for <lists+linux-efi@lfdr.de>; Wed, 13 Aug 2025 23:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 016354E2F22
	for <lists+linux-efi@lfdr.de>; Wed, 13 Aug 2025 21:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281DE2F99A0;
	Wed, 13 Aug 2025 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Qfm7Jp/n"
X-Original-To: linux-efi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022130.outbound.protection.outlook.com [52.101.43.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8AD2F1FDC;
	Wed, 13 Aug 2025 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755119986; cv=fail; b=s1d86guWwPgzHvHxXuYOaryBX7QopxLjrcibFg3xk7oe3FNbzNyVFbREwBULQ33JKlzFkVuzykchq42wicAiGQoWShdZT5OLqVlm+5gOuO8nWMXJhWLcVwZEMpyiG1l2o0iec0b0irl8hfpWMt1DssvpmhMhFqnjcvNfvLsuVDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755119986; c=relaxed/simple;
	bh=LlZZ0Gm00xCu5Lae6eN/LXpEBiAwLxBE9cvc3rBi8Ws=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FjQsw4K5uYsM6Dp4lmeCiHqrNw1CGnRcEGa+4LnPu2+VvzseWPVQ6Yd3CfJBJD6MIJVrpbcKKxM0+aitpXzjhIcbeOjX1VsV8sb5f04adR9/qPgXLjG1UKA6CTYkZWnjdHVgU8WFlK2y+ajFIK9tgk0wi1w7wKTiQZcOw0MHUXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Qfm7Jp/n; arc=fail smtp.client-ip=52.101.43.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hzajxw5Okw2KOxNmFo3RpXxThHS6NaRo0/hTtMqDoSUIWuwkbVlBHnjv5J/irAlPq5MGnzQkMrhxeuoPoGh8sfpOvsVjDNjBqK/N5EYzNbsuTKHcZhKn/w9xaV/X78gPaLOudxD817oy6Zbt2OrTRJ4oo5h+2Zj3um3juiCJUYbE1q5sF3H4r4NAUdly7Y/N3v5yV43Zkkgt4yzitmazw6ILegfI0eRUTkbcmeOKoU1+JEd7KnzDVR7y2bt0PD4dvpQ5xs3+V3AHpyx2j0Q+QOmJhHTFt/allSP4uzj2kAYygnQjLIALR07HgKs+GUV5Z5ILSXr4KMJ3ck8+92SAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5dTYyLO+c0RocfQ/gTdNVPVLsU4K+mEnn3DMqJxO1g=;
 b=REGOHJ0zr63b0oGbjOtql+thoCuhIWbg04fp1V27V+xiV7N6IP/KIQHSHDC07pu549MkD9atC9bAdGfvdL4AdbWYlYBV0a0cM+bNEXuR66QCrZzycQ+Ra9bD5ctmpcGy6ZtMObcChIveZxViot7pf1IglI7hLFjQawVVdE9++X2Dt7NfmdlcxSFacvgO7czy9q+R3GiR7QTcUj5trRIAeYQxuoTF5Q3q9kOFm99Brbi4Tf5rCKHDuGYB8wXBE1FNtQp771VxkSZurl1jkFYr5ObxHvGDuv7pzcbM9IFm1OwhPOCRUv0QR1tliQETMg7MzYM6rHOmJiF0Fw4axVdVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5dTYyLO+c0RocfQ/gTdNVPVLsU4K+mEnn3DMqJxO1g=;
 b=Qfm7Jp/nernP3nGyQ9MhZdaNT7xyV6JuCB00o6sA9HAfaUf88r2PfMW5CbTO7P1lXJYoS3PkC1u+3LUD/SWxfiN4+b3YJPu2XLfyIUV/1F5VS0dq83BzvgbehAd9Avb9aBrbPo2yQRdr4SUytdCJECs07crMOk5fyG9Z4Ilf08Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 SN4PR01MB7423.prod.exchangelabs.com (2603:10b6:806:1ea::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.14; Wed, 13 Aug 2025 21:19:41 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 21:19:40 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Date: Wed, 13 Aug 2025 14:19:15 -0700
Subject: [PATCH v5 2/5] efi/cper: Adjust infopfx size to accept an extra
 space
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250813-mauro_v3-v6-16-rev2-v5-2-954db8ccfbe6@os.amperecomputing.com>
References: <20250813-mauro_v3-v6-16-rev2-v5-0-954db8ccfbe6@os.amperecomputing.com>
In-Reply-To: <20250813-mauro_v3-v6-16-rev2-v5-0-954db8ccfbe6@os.amperecomputing.com>
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
X-ClientProxiedBy: CY5PR10CA0026.namprd10.prod.outlook.com
 (2603:10b6:930:1c::9) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|SN4PR01MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: ec73badc-e9bf-43ee-6cae-08dddaaf1da6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVpFSTlsU0FWNlkvR2lUNVUrRUc5NUNMeld4K1Vha01Vd1creWQ2eEgwM2tO?=
 =?utf-8?B?NXBqajlqVmFOckZ1TzhNTERXcEVHRnBtYWcxV2h5ejRjVVdLNDJGZ3hpSHhm?=
 =?utf-8?B?bGcwVm8zcEVqZE1EcG4zS3ptUnJlRkQzN2o4UTlLTC9OWVFST1YzbTJ0MGhr?=
 =?utf-8?B?czJRQlZ2TlFuTWwyRHF6ampQaUVQZ25weW5SNFo3bExublhWTXJkc0o5dEhQ?=
 =?utf-8?B?Y3VnZ2dCWUtiTkE5WVJpc0lwbkhxNVhwOStSK3Y0T2pGMnUrenpsQm84cHJJ?=
 =?utf-8?B?YloxSW83UnBpTDY3NFoxeDNZWi9BQWZmdEU1eXdOSjR6WEhzaHp2czhkZ05x?=
 =?utf-8?B?cEhGdFU2anBuRDlPSVl3MzVELzF0Qlo5NEEyQUtwRytKb1N4SzhYMHZFN0Z1?=
 =?utf-8?B?a2JDSHM1YzJZaTY4dnhlTGVvZ1lZazlsV2pjczdkQ1FCUFJFUnB2RzRrbWdF?=
 =?utf-8?B?Q25wdXRYT3FsTXhnVzd1ekt0M1crR0x2Z2hVRXlET3B3dzRTdnQvS0ZmK0Nr?=
 =?utf-8?B?ckJHbjdXbS9zTk8yWGVFbjBLNWhjbUtzbnZUU3hOVHJQQ21ON2JvUit3VnZN?=
 =?utf-8?B?UlJvSzdLN3BlTFBGcDE2VzZsRXY4VUM4cnZlL3V4VklZd2lodlBvY093bjdR?=
 =?utf-8?B?K25oU3VrOUlsUVdERGtLeEE1ZGNrbDB5d3ZuK3hObkpxaFlPcG4wT3M0KzRz?=
 =?utf-8?B?MEdPUURBNDRkc01HdnFDV0Rhekd0a0ZJVGFpRFIwN0F6VEFKaU9JOWZWRGFo?=
 =?utf-8?B?Y3BvWU5keFJ2RVR0dm9wZUphS0ltbHlScTRIWlE1VFY4QURabFU3aXBuam5q?=
 =?utf-8?B?M1FXMkRvVExTRmRZQ245WVg5endzRFRLa2piN2ZubUJkbW52dGZvaU9yaUNR?=
 =?utf-8?B?Y2IxRHFxelVMZm50YWJCOTE4eVRwRGJxMU9STUtiMjB3M2llbTc2QXovL2Fm?=
 =?utf-8?B?Z0hiQnFFY084cXNCYmVCYkh0cVhHdjhHYmFZVUhTS3VubVdRNG9peUtXU0Fo?=
 =?utf-8?B?MzlFY0FnVVdKUWNCRW9HSTVXdWloTnFTSDhOUFlxNjk3aWtHdzYxeGhjMU90?=
 =?utf-8?B?TitHb0JNNUpNdG9tZGZzZzc0QXVDbCtER0VSQnVzbDFCaDNBUjUvc3FqbjhJ?=
 =?utf-8?B?NnFoeUxDUGZ4S1VoQ0dWZ3dDMGFRV0ZKZXBnV2xZRU9ha201M3lPcjJQMisr?=
 =?utf-8?B?WndoNEFvYzdHOUN2enZYVnBmYTRxakVlZ2xrODE0WTR0L2FyMkZmQyt3dU9C?=
 =?utf-8?B?N2Nla0FvN20vb2lqVXVjRko1Q0NGVVJBczlMZDVVRTRWYi9RUjJSL2NiNk96?=
 =?utf-8?B?VWFmellBVnVWQWZaVUdUK1RhKzZjZVE4cFI5U08xblo2Nlh5THRMckRMSU1I?=
 =?utf-8?B?NFdqV0F1TEVWWmI4VVhHTHBnUXczb1NCem9yaFdmV1NaYllCYlBoQk15SWdz?=
 =?utf-8?B?R0lUT0Vlbm4xeDRvdTY1aGFXU3JQV1RYTU5ENTBXR0FUTkt6MFhPS3FEMXk4?=
 =?utf-8?B?QUROL2E4S240bDdTdjhmNEpDNXFqUGFXR084QVhRclRKWWcrRFdrNnd4c1VN?=
 =?utf-8?B?Y2RRWlJHZklNdFJPNWpFcll4Y3B6ck5JTlcvQ1VOdERGNzIwZFpiVXFoNHZo?=
 =?utf-8?B?UU54dVgxS3ZuUWtMZEpQYW5uUDljN3E4c1BDQ1QvMDN4RjRqVzd4QlJMVzRD?=
 =?utf-8?B?Y25Nc3VOeEczb3NJVnN6eTF4am1YbmVFNTJwTHY3c1lMTkVnT0ZSRTM1Yy9y?=
 =?utf-8?B?Mkp6cFVnVGRON1N6Szd3L29NeXMydDlqbE5KSGt0Ry9nV3JiVDhoVk1WT1p2?=
 =?utf-8?B?QUdPR3ZzalZOeU9VSXgvaVBFQjRaWGZ6NEFIVFh5cHJiZVZEMXJRL0puUThS?=
 =?utf-8?B?bllJdUxqMmpDQmFSUTdZdXZBc2plUHdCQ0lVeEtNMjRjcDFrd0g0aWdDQVN1?=
 =?utf-8?B?ZVR4UkNzRmFNYVJOcnRJcFplZXNIdTQxV24wYUF6dmgzU2xiVUl1ZXVIY1lp?=
 =?utf-8?B?djB5MmJwRXJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWQ2SXdVd0N2R1ZRaFNwZU4rQlE0M3JXcEpESFR2UGRPTE8xTEdiQ3hmYUpi?=
 =?utf-8?B?MmxGZjg4M2VxRUJ3cmsyVHQ1VU5kUk1zWitrSVdkNldkTFJBeU5yYzBBMUZ6?=
 =?utf-8?B?eXphcWZEd0JFZmhOdnpRcXVqcGJqQXRpYnNJWUhyd0hGTXlseTAyeGc0UmYw?=
 =?utf-8?B?RFR4dUFrS0pwZ2Y3Z2lGNXQ3Q3FQVE5yZ0djZ0tGYlV4NGFIdWM4VVdZd05H?=
 =?utf-8?B?V2RBdmRMSDFtVmhUMlMzUS94MVZQNWpVTnhrOXg5aU1UTk1ROWRueC9WbFJ1?=
 =?utf-8?B?UFBzUXVEWWtDNFA5RFU4NTdvaSsyTElrekNWcDhPOEpob0dmR3NzYVczVFhB?=
 =?utf-8?B?OU9XUnltTDNmYWJrYTg4Q1MvbkMyRGxBQUFwWXBpaXZ6ZnZacHhISzJTczVH?=
 =?utf-8?B?K1BUbFRoRkRWK3pJQm1sNmdHMHVsb280Q0xIQ3Mra2Y4N3BVWGw1UUFyaWFh?=
 =?utf-8?B?WThmQ2lwM3VoZG8rcWtiMmVLUTlMR0RKQllZbHgweTAzNDNKZVdkMmRtdUNV?=
 =?utf-8?B?R3NSeC9seHFTWWl6aklRV29pRHZXQU5YQUNuZno4MVZ3akxTdW9Ta2M0RHAy?=
 =?utf-8?B?SVU3b0Z4cVVJVTlSUHVsMlNNbzN4eGV6RTNWME5seS9vcnNMVkJVUDM0SXFL?=
 =?utf-8?B?QW0wWHRqTkNBUXNBRWtaOGM0dHFUWGd1alZGWWdEeXdSZlVacVd1aFRlcDRM?=
 =?utf-8?B?RmZvMjhNNDBvZ2Jtd3B3S2s4ZHNaSVNiZ0pPVE5FZmt3N040L1RaT05DMXRw?=
 =?utf-8?B?bGx2KzJRVC9hKzVJaDRuMjEwbXhGTmt0VHVqY3llcWVpZmZZeC9RMVVBWVYw?=
 =?utf-8?B?V05SK1lsSXVEUm42WUxYNGdRNysranlWM1FBL3JHMHZqVEJwNzdVSFpETmUv?=
 =?utf-8?B?K3FrcGxDOHcvaWdPMzVSM3lpcWVSOGZqdDhxb0JmSUw4dVNyYUV0MVhBUXNn?=
 =?utf-8?B?L09FTFM1R1owbTBFdnlQcW80bk4zU0UyRTd5T25SOUoxY2RNaWFRM1Zjby9V?=
 =?utf-8?B?cDlCZ1dCU2dvR2ZKNERXU0JCVWlicTBSSjRpYlZtektNYTdCQnVid0JWMDlK?=
 =?utf-8?B?VXZTN0Y4Umdhb1pqMm1OemdUSVVaU2JqVEJ1UjQxMm5tcUthSUlvTkN4RUtH?=
 =?utf-8?B?cWRxbnduY252d3BkNjBsdXcwa28yWUFReG5IZDVHbysvMWt6U1hRUS9lcGRV?=
 =?utf-8?B?elJ1NGJBS3FxaW5XMldtQVF0ZTkzUG5PeUNkYUpZWUhQTDRiVzhpOHR0NDJF?=
 =?utf-8?B?MjRFV1Racy9yTHlTcUZwc0p6UGZGZmtHUjRxQ3hZeG9rRmVnbzEwU0ppajA3?=
 =?utf-8?B?RVh3U2xZSE5pWnBtbDB3UWRyR2w4WmlBVm1QN1lFYlJCaXp0djBhTU1BaUN0?=
 =?utf-8?B?OGRyY3RCMUNIbzR1ZUhVT2tlZ21EWmI5TDVjK0M5SGhUTTFSRnZhUU1yMFNP?=
 =?utf-8?B?TXdIOGsyc1gxQ2hKeTNBTnpBMUlBaUN2TEY0L0RBZEkxeWI1ZnhKTEswdk5J?=
 =?utf-8?B?TVdvKy8reTBITDhTdmpWcU5oSURxeGRqQ0todk1zMlJvbGJ6c3AvcWVGZmRi?=
 =?utf-8?B?WUxENW1XZDV3akJ4em5nRHEyc0dDa0U0dFh2M0hGdWhVNWo0ZjNPcTRlRHlI?=
 =?utf-8?B?YjRmZFV0VjBQR0Nva2h6SGRVcktXMkFtbEpndFhGTFR2WDVsOWt0ZlB0c0Rx?=
 =?utf-8?B?a1pyNDV1OEgya2N3MzJYbFByUFo1WWRmUjZMN3pZQXhJZnRXeTlXKzRtVW9a?=
 =?utf-8?B?UFJ1dlhDdEpEd3dKeldvbFAzVjY4TFBPU0pIS2FYVFB2MFdKMS9kYkVKbmJt?=
 =?utf-8?B?SEZPWm9NaWptRmZOa0pJU1ZCL1lpUWp2S2RSWTgwanpJeXdrbzE2Y2dHUGxj?=
 =?utf-8?B?VGVJdkIvM2lvWGQ4a0JERjBiK3M0bnVBNzBHaU5SaWNaZjB1QUpQSnM0dlBL?=
 =?utf-8?B?b2Y2SllGL2JMVEMwcUNTd2o3YTMycUEvU00rUy9HV1lGazVSN3VTSWtnVm0r?=
 =?utf-8?B?TG5KOTM0VVZ0Q1RkUWVOdlpZQ09OK3hra0NiSjdRMEVwRWF4dS9sS0Y5dGFN?=
 =?utf-8?B?bkZIQ1ZEdkRLUjF5alBxNnQzMEtzRDlIZzVXTjdQMEtrWHFzVmtmSG1uV0hX?=
 =?utf-8?B?Qnl1TERRZjBnaDlOVzNFYWZGUHh1Nm0yaXpTWkM3SXRhUlVvUnhCdlZ4MWhl?=
 =?utf-8?Q?3FR+8HF+RqaOvgZsuTw+YgU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec73badc-e9bf-43ee-6cae-08dddaaf1da6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 21:19:40.9643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6Gk6z5VZCL5UuLTIo3i+CRc6hHPNc3k6V2v8EZxs6MUA5rl05nV8HV1LIl6Cbt2p6LcRb/gYIIRY5QYJH7HR1rYTFDv5rHGQIt6Ov9ya3GaYulrxTJ8q+QXe2NtJd0Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR01MB7423

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


