Return-Path: <linux-efi+bounces-4555-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1C2B26D1A
	for <lists+linux-efi@lfdr.de>; Thu, 14 Aug 2025 18:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B04FA242F7
	for <lists+linux-efi@lfdr.de>; Thu, 14 Aug 2025 16:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005C4285C9A;
	Thu, 14 Aug 2025 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="MgvlT7Li"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2136.outbound.protection.outlook.com [40.107.94.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36870222562;
	Thu, 14 Aug 2025 16:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755190392; cv=fail; b=eAiyQFsct7QnsIOVsADge1Mwms+kLk1xmbHxnvrHYERKDbVS4m3vAbKWMfGeJiI6+xORvf7dHwTVQJmpJOnSaI4Y+1bnRQaiUJUQQOF2C/9G/x9t7g8Xh5Yifhwslsv6gM0JLiVNFjTttDjG42QLxc06B6kAW5K8XnAcKo1we3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755190392; c=relaxed/simple;
	bh=LlZZ0Gm00xCu5Lae6eN/LXpEBiAwLxBE9cvc3rBi8Ws=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Svt1owkWU8X1cyAgiYKou2/2BBeV/ahv9JKMi4eZr0bpIqwgyg6aIvHesvnwDTmqUL+KycAo/PaVJg/ZiJxUQOB7hK0Fi/jFLm80igEyDsFiOALseSkvPxbNA4GEoyRupLuPrZwLkTYmx80B9E75KguPJwOEXXPedjLrZkEQqsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=MgvlT7Li; arc=fail smtp.client-ip=40.107.94.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSp8u5RFz0BtxjYO5rFibuGoMZVPUajlzbbI5gOvFIipP/QKAqdjfRqMUd+SPs2+077VfqWEzaZAD6rIXYwE47PchhShP+Nw2ysFmezah8+7lSLnk4l4HqApeKiuo9N2pP5koWtsRsdGCRrcM9C4HlL7d4rn8/lS0bRwdydYINQhG02Rz+K/WM25i5jdUfzExP7dmnIftjZfI10qpdNkmJ5I8jX/8Fn4ezOIvRBVUXcNBSg6iEjFXoWgqeF0AJBIFHhyFsgSQLRBKlJLF0VGGxN3NNx0a78DqiOCCw7aciRMT9dUGS6jS6VRD38FnPbbxzoMjouwAM9MsoowS3SWIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N5dTYyLO+c0RocfQ/gTdNVPVLsU4K+mEnn3DMqJxO1g=;
 b=sRMrEG1S+RozdkJFAsgkdLAMNU59899oCmw2ZScQ55fMVixUcG40/zdoFftlVDOIYGfh1gI3yRLU0wafhGVKMWyTjFTy6f/IgFS6rZ0u2Ao1ufUTuWmIRKFpp41pXVGgOkE79hteRKmleQ6KVUL74YxPXUw9KjF+kL4cQOvF7135PNsKkVUqTBlB8SSP/ZoOqtJh+S7oRYjc+Q/W3B33wT/rvzC6ibRWrbZwa7p0d8sW6MrMBn23tZ3n2HUo6bSC/mBDmo41ntvFl6XHI3jnhfRn4weTL+47WP6aYrGxieTEOame9iYCDbcaiKki9rIx/wc8DoQiUMLNd+ahqVzufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N5dTYyLO+c0RocfQ/gTdNVPVLsU4K+mEnn3DMqJxO1g=;
 b=MgvlT7Li40DuhSl9KNRJTPZpz4i1+NBUcr3SuO2Pmk3KsfsbkaS0+l1SHQIykezeOPNrk1tmkEY4tuSkcAkqCkw1EYPEmZsKJOPTSPabwJXC+FvDG1uhG0hn7uh9OVkIRbgm5e1wm2g02PrnxvIBqPleW/Qq7PvM36lKnnEw9SA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 BL3PR01MB6881.prod.exchangelabs.com (2603:10b6:208:354::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.18; Thu, 14 Aug 2025 16:53:06 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 16:53:06 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Date: Thu, 14 Aug 2025 09:52:53 -0700
Subject: [PATCH v6 2/5] efi/cper: Adjust infopfx size to accept an extra
 space
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250814-mauro_v3-v6-16-rev2-v6-2-e5538d534aa0@os.amperecomputing.com>
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
X-ClientProxiedBy: CH0PR03CA0384.namprd03.prod.outlook.com
 (2603:10b6:610:119::26) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|BL3PR01MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: a996e30d-6ecb-4629-5e40-08dddb530aa2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2RWNkkyL0JwakczZmJOOVBVTWRUV3ZjNW8xSmRucTRaYjVhZTdWUmhwT1R0?=
 =?utf-8?B?bGIvWXJxcU1JUFJjNjEwSHV4dEpCQVJOc05vRVphU090L3liYnpNR252eW9S?=
 =?utf-8?B?bWJjQWM2LzBYWDh3eGlETy9wVHFoUDhQMDg0S0hXMWphWFMzOWwwR0dRcENT?=
 =?utf-8?B?cHF3T2xQQ1lYWWh4VWttY1huUWs2N1V0UFVxK0pKTXFKalp0RUozVWViV2k5?=
 =?utf-8?B?a0hySjNFZmJ0VHVTamxJbFpvY1lGSUNLMEhabkQ1S3Y4US9ENk1uZnVVYUNs?=
 =?utf-8?B?NU1BcUxjaXNBN1BYQURwbUNIamI5YXZ0cHRsbFFIYUhHR1YwUkw2bStQeTdj?=
 =?utf-8?B?bkJtUnBjY2RPMTd4QXBJMUVnaEdmSW9FZjREY25zQUJrOGFFVmdGcG1RQS9r?=
 =?utf-8?B?TUFmcUthKytnTHdtYTQzYWdGRTAyVTVmWmNhZEo5V2MrR1lCNEdCRjlVVG5Y?=
 =?utf-8?B?NlIyT1ZUVkZSZVkwZ2x6OHVuVVNLVzhseWYySUxsYk5Ra1BrUWEvQWhDTHow?=
 =?utf-8?B?SDAybkgvRE5xYlB1UXZoeHdINlFTcSsvaXZmcnRac25SYzllYjNxYWNQeUVw?=
 =?utf-8?B?L2tWUjVtaWhVdXV1QTlLNkFId3hiKzVpaTNIMHdUTWczMWRVZUN2bm95dmhN?=
 =?utf-8?B?VkZ1WlMxQ2kxb2I0VnpWcjJnbkVSNGxSZ0NIRlhqOE5hTUVSdHM5SjhwV3pt?=
 =?utf-8?B?eWlaZ2xjTkZxRGh6WHhhaUZlV2xqb3RRaVJuaHVYRkVwMUJCa1dpdGgzdjBF?=
 =?utf-8?B?bmhCOVNBM3ZZWm1SamREaEtVYUtHczRMcSswaXplTEt0Qll4YTVYQVNsMEZJ?=
 =?utf-8?B?b1ZCSHpQM0R3L1hxZkloLzB6dVA5cEVMWW5ENnNvb3QzaGduRG9VMXBKMVFR?=
 =?utf-8?B?MWtnTksrVVRLYWpYRFh5dmRzZkE5K1djZkloK2J1ZWFoL016LzFCcUhqdXhW?=
 =?utf-8?B?N1pTWng5RWtuNjZkWHYyKzRLb2lUSWRzTFFPYkZYL2tvRVVLWlViSFFTUEFC?=
 =?utf-8?B?bkZCc2g0cUhydlJLZkpmc0NhQUhaQ0JUbkp1akRXU3F6d3Z4UWd3WVVLT1ph?=
 =?utf-8?B?MkhwZkJjVUZ3ajNGRUlxemJwcFNZdEtiNlRWaXBicEVteWtjRURNMkMwMzZi?=
 =?utf-8?B?UmhRb005amRsUGMySTRkTlZ0eWJnWnRidVhjTHp0VWpYdkpyQkhWcDRhY0Jy?=
 =?utf-8?B?dEVBTGVuTG81SXROM29iQ3BFcTdpMWlJZTFGZnROaWxmMEpjQzIrc1p6eEow?=
 =?utf-8?B?alRYUTFFcnZzQ1Ava2tXZmJiTlNyRHRmRmM2dWhMMDBCeWt6L2Rydlc1UUx3?=
 =?utf-8?B?NEhBZExCWnBwWVRkVFVxN3dCd1dFaWFZa1psWStJTDUyaEtaRlRLUW0zK1Q0?=
 =?utf-8?B?NDYrR2dNYUNnLzV2OGVlam1FQVliN1U5VnVsYmJ5RkVQRDV4ekQ4RU80UUhB?=
 =?utf-8?B?cElOZFNLVVBmZ1l5NTdtam5OOVNOSUprMldXZVBpV3pjaUgwcXVWTlhsR25y?=
 =?utf-8?B?U29Fd3BSRTdsMThNK08rdnlOTXowTDNaZmcyNFFnUTNpSVNKb3pFYmRWYnVG?=
 =?utf-8?B?UEoyQjlaRVdQdEJxeG05TXpyMnlNa3pvNlNoQ0hrdERuRCtvL0s4ZVVYRkV3?=
 =?utf-8?B?SEFwU1NIbTUrVWRrNHA3dHFPejdwd0VFRytQR2Y1NmhJeHF4VGRHbTZPSnZl?=
 =?utf-8?B?aWJ3SzBUbmpOWVVpRy9HajZZTzhGSW94V0lJTE1SSlMya1o1Z0l0Qno5WVly?=
 =?utf-8?B?SDFUdzJ4cC93MTFaMm1PWlVjd1UwNUM0YXhWMEovUVU0L0NQYTgwZXdPV250?=
 =?utf-8?B?cUhGNjBMRG5kR0NvMnhtb2hESzZaS0RiUUh1bjNzNjY2L3J5NXQvd3VXVlRG?=
 =?utf-8?B?akpNek4vZE00ZjZjaXo0MmhramRNL092Q0lhVjloRGIxVEptRlVCQ1AvM0h3?=
 =?utf-8?B?blVRa2M5aWNXa3dUR0NzY2J6ZlFLemJwM24wS055TlUrVXFWTHhzeFFJZDl4?=
 =?utf-8?B?bC9mMXI3SzhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejRTbk9TSXpmdWdUSDFnVlFzcUJ3QS9kYTMyRHJnQjVjWkZwV1ozWktnbjZU?=
 =?utf-8?B?M2JycElaUmVHYUpaV3BnNnp0MmtxdXN2aWR3SWpVZkg5U3V1aFZsaTdqbnpK?=
 =?utf-8?B?RmUreUNkenBIRk1LK0ZKMVlldG5aUEZvcGhYbWtDa0Z1U3N5encyV0pzenM4?=
 =?utf-8?B?NjJRcE9ZemZwUHVkOGFMSjV1bi9MZXFLMFJQNXFaZWhiMnVTQVRsN3k0MlVD?=
 =?utf-8?B?OXlkdWh2STRkUXorRTlFZDlPK2FpK1pnM2NRSmYyei9yeHBOeGtwc2tpM2o0?=
 =?utf-8?B?bW1ybGNEZ2pIRWxucWVKN0FidXltOXlnZnA0SUFVL1V6WCsrM2FqVXJ4c2VN?=
 =?utf-8?B?RXVVZDc2bThiQTNWd2VuN1VkUTJ6RVV0bU9aMi9JM0R6L3c4bjl6SUlTbHc0?=
 =?utf-8?B?MEFpdy9TUzRvaFZRYlMyazkrengreTk0ZlpHYVNSMXN3alVFTXJHUy9EZS9Z?=
 =?utf-8?B?TWhMK1NVVlRYNzRvUUVlSXhLczc3cXkwNjkxb2ZhTW5Tcmd5NmFjOW4wdnRh?=
 =?utf-8?B?bDlucjBOUzFlMHBTcmRURlBQUFEvZzRtOG1qaFNZSHAwTzZVQWo2Z09oTTJ2?=
 =?utf-8?B?TUNLYWZrenUwZ1NmVGZqZ0t5QWMrWEt4OEZLaWVMRGVCN0czUUpmSTVlZld6?=
 =?utf-8?B?SjFaTG1OY1IzTmFvamgvTmxGVDVtYkZZUE96UzV2R2xzWG5iTDhOVmZCYnRI?=
 =?utf-8?B?SjNPVk5VaGN5Skd1ZFo2dUlwVXBWK1JjSE5BZ2ZsUk9vSFdqOW1OeE91QklF?=
 =?utf-8?B?UDl5OUpNTGVzNVpUU2FSNjh1Yi9xVWNNZjRDWEw2dUtTS0oycEI5d1BMd00v?=
 =?utf-8?B?VGI4M3BaMHlPeVRlWktWWlU0RmNaWkdUWU1icUNkQ21JTWs0TXNKK1dvajZ0?=
 =?utf-8?B?ZWFrZVVQOTM4aUFOL3YxdGhFUEk0VWhJeGh3Y29CSGFMNnlqdDkwUnkrMFY5?=
 =?utf-8?B?VG5MQ2MxcnhuQUdIU1hTc0xKMFFPUEh0eU56RXdPYVhRbisvdnlweUM4ZmlU?=
 =?utf-8?B?SUl4amRmTll6d0pnRFN6aWJRN0M0RHRUUXgyN3NkVURHZjJZc3dRenYxUE5p?=
 =?utf-8?B?K0RtRFVubHMrNUpXUU11UFUvbkl4bVBxU1pIanRuVnluNjVNSmI4T2FhZ1U5?=
 =?utf-8?B?MkoxdmJTNU1SUVVPRGc2ckdDMnZBUENtcWw3TzJMQlZnajh6L0pXT1RVSldk?=
 =?utf-8?B?cVkvR3dIcHo3ZFRCZ1p6L3RNejFqZ0gwRXovZnZaVkh0RmVadDM2R2RRZklF?=
 =?utf-8?B?Nm14UktYbFRCeGJ5VnIvUDFOdXJVaTVzcG12aFh6M1poOHN0OG10clpFZGVI?=
 =?utf-8?B?MFpUSldveDY1SE5JYmZwUmRxbDFGczYrVFhmYzhucmhrcFNSNS90M1M1V25F?=
 =?utf-8?B?QTAyYWhqeXlKajErK2FvUkVzc2p6UTgvc3BueDRCekNuRlVSWnhyWnIvT3Ay?=
 =?utf-8?B?Zk9yL2RDSEpKekx1TVRGazd0bHI5ZGpvS2JranF6RS9NVXBObjRROXk5cGox?=
 =?utf-8?B?cDVINzlkQ2d1cDJLRzdhSDhpcVdkUmtSZCtzNFFqSFJsUHJXQ0w1WUZFbHpB?=
 =?utf-8?B?ZUhFZzcxK0VZTC9OendadDlBTlBKYVVhaW5IVzhSNzJzVjJtZ0VnNmhFYjFY?=
 =?utf-8?B?RWJ4QVMrZ3RhWlNUUm90azR0T0JvNHpvbEVFN3k2RFVxUFhYTHlJd2oybVlr?=
 =?utf-8?B?WXMzRU1Nb1VKOXM5SHZBL1dRaG9FczUreHlPV25wZ1VQQ2lQcWI5SzV4cFRq?=
 =?utf-8?B?MnNOOEdvalQwelgxYzltNWwzWEFzWEw2VlNEMXg1RGVOV3hudXlyN0N6bmV2?=
 =?utf-8?B?TjRJRElzMXhyUHZleWgyaVFHbnRqSXR0cWtHaFQxS2Q3SmhLU3ovSmtNb2d2?=
 =?utf-8?B?akczbGdHVUg5Zy95WFJqUUJIRTdtQTZwYWNnYXZsWFd3T25EWWt1VG12UDc0?=
 =?utf-8?B?emFnRVVmY2FHdzBCZzF3Zk85RTA4OG1FYnU1b3B5dTBJZUZUTWs2eXZzclVq?=
 =?utf-8?B?dFpRcGcxRXFIRlQ5NGF3S1lDakZZRDdMYjQ3eVE3SlVVb21hVWlTRTBqKzBE?=
 =?utf-8?B?ZklRWjhydW96TzJJNXpkbmo3NElqeVVVTEJNNHhGYzV2QTh3c1VEdjVFdEVa?=
 =?utf-8?B?UzROVWN2R0NiT0hlWlljWkt1RVQwSkt0QXo1NGRucWZLT2xJVjJrM0wxUWhE?=
 =?utf-8?Q?HUkSaP5v7wy4GHp9wdNcg/k=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a996e30d-6ecb-4629-5e40-08dddb530aa2
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 16:53:06.5562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TJ5yIoBxT6DlqYVsf3FFPglISvp4baoaPPbMqlTdFK+2uPiaTSmlY0ng3cAmUkjUX4ONtSFV6a/WOrZlVIRP+R8PyhEbsEc9u5qE5y30iju+eBrB2w3itIWRtCl6QRhj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB6881

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


