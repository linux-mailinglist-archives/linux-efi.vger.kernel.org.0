Return-Path: <linux-efi+bounces-2773-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05505A2DF0B
	for <lists+linux-efi@lfdr.de>; Sun,  9 Feb 2025 17:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18EB61886A1F
	for <lists+linux-efi@lfdr.de>; Sun,  9 Feb 2025 16:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC101DED7B;
	Sun,  9 Feb 2025 16:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="by1t+zhX"
X-Original-To: linux-efi@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856714C9F;
	Sun,  9 Feb 2025 16:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739117628; cv=fail; b=Z0tACrBL697bhlhblcFR63OO/8sLB1ffIPZRE6DxMhFWu6MIavUwL+zlTeWyXjESyR3OWFl4Z6hiCP30MypFL9uPMdxchEp96saeDxKXOaH3feF9uY7UfophJvdLpf++woq7Cc2xVAb4e4zbBo7zRaetVbNbij33PUtNPqu5cfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739117628; c=relaxed/simple;
	bh=1xLAg7yGaDPHHNWWvDdKc+cBwW+q34MI3HlkBNWmjWM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tX8TqR42bETe/skorhbYQgIqjD+zZXvHQXNyNhqC1KfQ7mGlLkS9cgW9F9r5vOfjHUetl7Xz2qYpvJznwTRk6h1r+AFwk87qPXoLomc0Y+tivvRWghvp2J9q4rGVuPSz5Ey1X/9E7M7z9cHlcgOxR27kkAZAY67wgFyBDL6JQMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=by1t+zhX; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdgHStjAf6iAL3h1nPgvuH4IsrdII3HdzmQuMRlIwAwszGEd10sMxi2y1WwMXQg5X0SqawfMenKXSDtVG65bHtfGO8rrHeExJR0pNspoI7HpLdqVD0vjEBvFcF6dfsTXP4syTKLKoulG3cHrgAAI8I56tGo2+XEYZCxQXmrFAQILyO3fMZ9xNMJPwsbIvHbKUNW5ts8QJ1xs1dUsGgIOo6Vqy5OFcX+b5cYzLfVqFFmC506KmB2u0UV0gyffb/6ZOkJt0Vdp1vtpy+EFj+1j6Ae3/0ggSpErnbMlFeUj0Lf2TvIH7cEg2N4V0GImWgoH6infykJ6KlbGYyWC0Q536g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1xLAg7yGaDPHHNWWvDdKc+cBwW+q34MI3HlkBNWmjWM=;
 b=WSHTuOw+V9V4+SpnlxDoB/FY8YU1m0rBI5ZXwBRXjVjzIwNzvYDYJHyfuvd7NJapRKKN+Rlo5RKYLCWCR7KVsKkfeci1La7FAh359Pu2sUY6uLx4fXvtqjgXKkerLtfUUqOY7xrvspnNitZxowC8GCt7uccuYMAfGORpT16tG9O8X09THIAV6sEy94BfQu87Cq/VrLJTXkeBiqQr/6fzSJn+842uFyDwNRox04KnqOxKVdvjyoi1r/jKMECjYyzRJwFlk01r/yTa3V1We5EfXlErIRMVHQ3psHPvAHNymJFDnsFQWOmeR1XuZ5TN8qmTeHvb+fDU/7aK1Io9FgN+VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1xLAg7yGaDPHHNWWvDdKc+cBwW+q34MI3HlkBNWmjWM=;
 b=by1t+zhXpdvNzIzk8AUbnGwbA91iYlAh3++aSP8j7myhdFRpSm9WvCF1GZY+fgIQBfE7tTdCR1BQqcZNLYbnmAfi0xv71ILhyT/8jyXagvFdV6V5tsexEHE5JgEGEPyuQRh5faIUWjFKthCG2g07Qa6mpgOGbcrMT698D/QjU0Sv4QndhZb1ffIBSl82NPoOPUbxvnp+ifXpOEMxNcu/K+mzgJ9l+YSGXYpeNW8dvhDuu8EAZ0BpWE/xAKuOouyUuVDUIvPxRZmIId7ZlbppVSMe1mGOECsNoGp7tm9NqtMJ6m4F78YFsZh4tquYoILaB/kO0WdbsJxJ++9bQkA+IQ==
Received: from PN0PR01MB9608.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:110::10)
 by PN0PR01MB6462.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:73::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Sun, 9 Feb
 2025 16:13:37 +0000
Received: from PN0PR01MB9608.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::972:abe8:752:bbde]) by PN0PR01MB9608.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::972:abe8:752:bbde%5]) with mapi id 15.20.8422.015; Sun, 9 Feb 2025
 16:13:37 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Lleyton Gray <lleyton@fyralabs.com>
CC: Jonathan Corbet <corbet@lwn.net>, Ard Biesheuvel <ardb@kernel.org>, "Paul
 E. McKenney" <paulmck@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Thomas Huth <thuth@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
	Xiongwei Song <xiongwei.song@windriver.com>, Jeremy Linton
	<jeremy.linton@arm.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jonathan Marek <jonathan@marek.ca>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Kees Cook <kees@kernel.org>, "Borislav
 Petkov (AMD)" <bp@alien8.de>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] x86/efistub: Add options for forcing Apple set_os
 protocol
Thread-Topic: [PATCH] x86/efistub: Add options for forcing Apple set_os
 protocol
Thread-Index: AQHbWWa5RmJr6eRYF0KZY8iXtrQUd7M/aEqA
Date: Sun, 9 Feb 2025 16:13:37 +0000
Message-ID: <4564637B-36D5-408D-B0CA-816D9F3466E4@live.com>
References: <20241228202212.89069-1-lleyton@fyralabs.com>
In-Reply-To: <20241228202212.89069-1-lleyton@fyralabs.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0PR01MB9608:EE_|PN0PR01MB6462:EE_
x-ms-office365-filtering-correlation-id: 08e6bfc4-cad7-427c-96b5-08dd4924b608
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599003|461199028|15080799006|8062599003|8060799006|19110799003|102099032|440099028|3412199025|41001999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWlWVkxvU0Q0cEZQSGNXcm44aGM0aEZkZHFrem9Wc2oxUHpLTEJjTUR1L25H?=
 =?utf-8?B?N0srV2E4QXU4Y0l4amczUS9BN2h5dndROTh4aHhVS0FpRFFyaEMvSHFtK1Mr?=
 =?utf-8?B?OE9lUWZJVFQyYXIzZmNUa0d1QkxyQW54YUxjUzFIQTdQc0g3QW8vY3NYVmVW?=
 =?utf-8?B?bEdNRHpZNnNBWEJVZFhDbWtDRjdzZjJuZHIrZFVNZDJNekk5eDhDOS9sN0VP?=
 =?utf-8?B?QW4xbk5zdVZLVFNnR1NHVXdUdm1hMDJGeXhtbUQrZkFLbXRPL3FuNVFZc1h5?=
 =?utf-8?B?MnhaaFRnemF3Y252V1o2dHMrRExLZlpXcXR6S1lJTW5wNHZaMWtUbEZmYnM1?=
 =?utf-8?B?SVR5VGZPcEpjbHUxanlBR1ZEOXo0a3piZ2FQbGQ0VUdYZ0lFNHJFdmt2L1k1?=
 =?utf-8?B?a1RUeUtQdkkwQ2xlNWVlNXpMaDVSSHcwSWo2TGNRRDNxQVdHMDIzaENYTU55?=
 =?utf-8?B?MW9jSmdHTnhxaklDTnVTeXkrUE50bXJSckV4RE9UMGtmajlEN1BvSUlvYnov?=
 =?utf-8?B?VGZrM2k5MXRkc3BXZHo3V0szYXpEQWdSQTdxdnhwczllOC9hTUFzckFMMUFi?=
 =?utf-8?B?MmdHTzUwTEVSeXo3R29GN293VUtRcWZzN0hpNjdFOFpCYzZPUDZ5WVNxNDdF?=
 =?utf-8?B?UjNLQWx4MGgvQm5pcVBhdEZweXpYenlPa0pyZmhlSmcvem9qRVdyYU0vZmF1?=
 =?utf-8?B?YU5wZzBCMTJ2ZG5DWERJZXdsVnRnWkVOZk10bkpreS8rbXBJWWUySGRFYkd6?=
 =?utf-8?B?Mmhnam51ZjRrNG5DL04wcS9wbWRrYUJiaDlqZERRay8xTEJCZm5CTlRsaWp5?=
 =?utf-8?B?TWw1aHp0NFc4N1pPVlhPTGtZZzhqNEQwdHBhYTYzdi9hcEFxc3N5aWJyVENT?=
 =?utf-8?B?a2VjaUNlcjdLZkg3YkhROW9VVmNHZWFxKzN0MkUrUlpweFA1TEs4RG50Q081?=
 =?utf-8?B?VVFmVFc3TmdhZVVFNXpLMHBFNmF1M2t0d29HSjBhUTlrVjdudHVqUzVHZmFN?=
 =?utf-8?B?aklaYXl2dmIwSHVjNFdFNlJ1NGFSWDJ5RGhRdE5vZ0toZ0JJd1h4NmZoVEhl?=
 =?utf-8?B?UU14aE9mV1lTWGYrTUxPK0Z6S0l0Q0huZTJVRjIwTWRKRE9Wa1d0d2t6K0lV?=
 =?utf-8?B?UE9pMTR1QmIvRHU0blJ6SGptdkdtTXJ5OTJqUUI4SXBiS3BlNjVvbi9HdHJS?=
 =?utf-8?B?N2RmdWU2U01qdnVESGdaTmJpLzlIZWlYVkpKM0gralBuZ1NIWEhVVmg2SnlJ?=
 =?utf-8?B?MExzUVdTNk11T3FJMjlHZ29EcTNBU2VGdTJra3B3MEVFNHRLNFM3eTNta0ZT?=
 =?utf-8?B?V2ZjcUIwVkJMVnMweWdXUmhsVUdXVHFJSzQvbzV3UUZZWHNWTlZMV1ViMWlD?=
 =?utf-8?B?SWUzdkQrd2RRUmZXajh2OGNwYjFYRHVzUGlaSmszc0hqcWgvVXdoZzdraFJU?=
 =?utf-8?B?WHQ4YjloM1FSMHhFWFlaOVZCTEZkQVhKczJKLytRclVZTmNmUzhVWmNJQlFV?=
 =?utf-8?Q?LgO3fE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3FrbGR3N0l2OWtoemhsOVFqU0JsL3hwTklCeDhOVlR4OXk0aXpkNU9ncDND?=
 =?utf-8?B?SzFDMmxPRFlCdnNVUFFrM0hrOUMwZ0ZuZW5PL24yeWVMNkN0NFF0UXN2WG16?=
 =?utf-8?B?M3hOc1g3V09FdFdvNFR0Sk93b0JiSnpnMURlT21zaTQrNjZVOEVacWc0YjZF?=
 =?utf-8?B?K0REbHJPVEtlQUpENXJMaSs1azhleVl3TlM2RWxiRE5BeG41bytDbmQ5U2Rz?=
 =?utf-8?B?Ri9WNkcvQ01iRFN2Qm0xd3VuUUE4cnpBS09IdytzRUticTFCWUJ5SEsrQlRo?=
 =?utf-8?B?Vy81UU1ZVzRuNjIyUzM4RVBOTVYyb2hTNHU1ZU90SnFTY1V6UzA3Mit1akVU?=
 =?utf-8?B?SVRIVTJ0RlRBWUNjZkI2OFpBSXY5a1FtY0g4Q2VFVUNlcnVHTTBxaVpoOFE0?=
 =?utf-8?B?YlJMTUtLcm9qU2ZUZlBnUUwvU0hCUERma3VwbmVGZHZ5aWR6UlhpZW00R053?=
 =?utf-8?B?T0NLQjRTT3kwZXR5WEFKeHNKVEpRR0poVUxkVzlqRWljRFB2NDNEWitUdHJG?=
 =?utf-8?B?cXdMWXRPUE8zWEwvb0U2a1VrQjZ6cWQ3Y1BrWGE3RWFMSmRWemZQV2xYZVpo?=
 =?utf-8?B?RnREMk9TeWRqaGp0cWp2WU5HMzhzcmhJakZhZnpJYThrbHp1NE5zcUt3NDAw?=
 =?utf-8?B?VktOVzJVbHdJdnJsdzZhTk1wNDhLNUFkTEd0WUkrQmFJd2dkelFraGpuM3Vv?=
 =?utf-8?B?QTlXVHJuSkxvZVhGbVFkNHUvekhMN3pqb0VSakliVXZUTXVOYzhhcmt6VEhu?=
 =?utf-8?B?blp0L0xIQkpLV0VrSGF5QzBiY2VuRUpZczMvUGJCbDJFenVmeGpCM09iUDNr?=
 =?utf-8?B?ckc3R20xWlBwTUlieWVsMlJ2KzErLzhXNnFkNkdTM01wL3RNSGxuaUI0Sk03?=
 =?utf-8?B?OTBPTE9maWtZbTlhUC9hdi8zL0I5Y1JLdFBlVnQxdkdVV0t1dy9WV0E2WXRX?=
 =?utf-8?B?RzRndFlHNkd0eFN0SjRWT2s0ZC9FR1dDQ25CRldmcEhwZXR2N2VQRFRaMVpS?=
 =?utf-8?B?N2ZybmlvNlREL25Jc29rckpRTjlKTmdMUkxkQ2tGWTJOendDR1FSMWVrUUt4?=
 =?utf-8?B?Z1Q5a0NyZFJwYS9GR1dnTnF1Njk4a1YzUi8zL3FremVtNEcwNm1PY2t5QWMw?=
 =?utf-8?B?c1dObU4xL3Q3VlgzNXNPYTVHT3JlWU51MkIwWmwxejZmOCtxZlg4Wml6aStD?=
 =?utf-8?B?R04xMTJHSXRqSGJobjhacmJtaDhSb3NqSlB3TGwxV2xvb3ZuV2dHd3dKOXNP?=
 =?utf-8?B?em1sdktFMlkyRHozSXc1Ni81T3dVNWpPNFlKRzdkakpMQm56dEo5cWZ6b1Ji?=
 =?utf-8?B?eU1DR3NGTjV1T09nay9YeUV5TnlaQzJ4Zll1LzFnRmtMaGZ2OXhjZFZCYTFo?=
 =?utf-8?B?bkxoYk1nU0ttOEg2cHRMdmlYdHd0Y1hYMmNUcnRscEYrMGkwL2VFdld2ZVVv?=
 =?utf-8?B?bTUzdlpEb3owVG12WTA0MGpzMCtrVXhOSmFOT3ZFcnptZFVBc2hPY1VmaERZ?=
 =?utf-8?B?alVMcW9MUVhPRXZXYWZXVDhFU0xlcDAwSzYrL2NlOUJVR2xaekpyUytOdGU3?=
 =?utf-8?B?M1Y3bWNvM1BhK2ZCdGlnOFpyY2VjTEpQZ2xTR25WRCswLzBackQ2SGlBR3pN?=
 =?utf-8?B?eVBqSzMxci9uVXhjZHhucEVmRnFsdmZ2MWJPWnVudzJ0cGFieEtiSEQ3dTdP?=
 =?utf-8?B?NHgwc2tDdWVjeWN4YWRVWEprM0tkYmZPbTNZKzNVaTdmbTlaajN1b0JQK1VE?=
 =?utf-8?Q?PR6V6aIdTNsfnuYGeWwSuVpBA6Wi3HqBfTcRs4X?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A90D58C35626940A8EC539472E79AB4@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9608.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e6bfc4-cad7-427c-96b5-08dd4924b608
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2025 16:13:37.7866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB6462

SGkgYWxsDQoNCkkgbWFuYWdlZCB0byBnZXQgZmVlZGJhY2tzIHJlZ2FyZGluZyBlR1BVcyBvbiBv
bGRlciBub24gVDIgTWFjQm9va3MsIGFuZCBjYW4gY29uZmlybSB0aGF0IGFwcGxlLXNldC1vcyBp
cyBuZWVkZWQgdGhlcmUgYXMgd2VsbC4NCg0KSSB3YXMgd29uZGVyaW5nIGlmIHdlIGNhbiByZWFj
aCBhIGNvbmNsdXNpb24gZm9yIHRoaXMgY2FzZSBoZXJlLg0KDQo+IE9uIDI5IERlYyAyMDI0LCBh
dCAxOjUx4oCvQU0sIExsZXl0b24gR3JheSA8bGxleXRvbkBmeXJhbGFicy5jb20+IHdyb3RlOg0K
PiANCj4gY29tbWl0IDcxZTQ5ZWNjZGNhNiAoIng4Ni9lZmlzdHViOiBDYWxsIEFwcGxlIHNldF9v
cyBwcm90b2NvbCBvbiBkdWFsIEdQVQ0KPiBJbnRlbCBNYWNzIikgY2FsbHMgdGhlIEFwcGxlIHNl
dF9vcyBwcm90b2NvbCwgYnV0IG9ubHkgb24gVDIgTWFjYm9vayBQcm8NCj4gbW9kZWxzLiBUaGlz
IGNhdXNlcyBpc3N1ZXMgb24gb3RoZXIgVDIgbW9kZWxzIHdoZW4gYW4gZWdwdSBpcyB1c2VkLg0K
PiBBZGQgdHdvIG9wdGlvbnMgd2hpY2ggYWxsb3cgZm9yY2UgZW5hYmxpbmcgb3IgZGlzYWJsaW5n
IHVzYWdlIG9mIHRoZQ0KPiBwcm90b2NvbCB0byBmaXguDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBM
bGV5dG9uIEdyYXkgPGxsZXl0b25AZnlyYWxhYnMuY29tPg0KPiAtLS0NCj4gRG9jdW1lbnRhdGlv
bi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQgfCA3ICsrKysrKy0NCj4gZHJpdmVy
cy9maXJtd2FyZS9lZmkvbGlic3R1Yi9lZmktc3R1Yi1oZWxwZXIuYyAgfCA2ICsrKysrKw0KPiBk
cml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL2VmaXN0dWIuaCAgICAgICAgICB8IDIgKysNCj4g
ZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi94ODYtc3R1Yi5jICAgICAgICAgfCAzICsrLQ0K
PiA0IGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVy
cy50eHQgYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0K
PiBpbmRleCAxNTE4MzQzYmJlMjIuLjFkMWI4OGM1N2M0NCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1l
bnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQNCj4gKysrIGIvRG9jdW1l
bnRhdGlvbi9hZG1pbi1ndWlkZS9rZXJuZWwtcGFyYW1ldGVycy50eHQNCj4gQEAgLTE0NDcsNyAr
MTQ0Nyw4IEBADQo+IGVmaT0gW0VGSSxFQVJMWV0NCj4gRm9ybWF0OiB7ICJkZWJ1ZyIsICJkaXNh
YmxlX2Vhcmx5X3BjaV9kbWEiLA0KPiAgIm5vY2h1bmsiLCAibm9ydW50aW1lIiwgIm5vc29mdHJl
c2VydmUiLA0KPiAtICAibm92YW1hcCIsICJub19kaXNhYmxlX2Vhcmx5X3BjaV9kbWEiIH0NCj4g
KyAgIm5vdmFtYXAiLCAibm9fZGlzYWJsZV9lYXJseV9wY2lfZG1hIiwNCj4gKyAgImVuYWJsZV9h
cHBsZV9zZXRfb3MiLCAiZGlzYWJsZV9hcHBsZV9zZXRfb3MiIH0NCj4gZGVidWc6IGVuYWJsZSBt
aXNjIGRlYnVnIG91dHB1dC4NCj4gZGlzYWJsZV9lYXJseV9wY2lfZG1hOiBkaXNhYmxlIHRoZSBi
dXNtYXN0ZXIgYml0IG9uIGFsbA0KPiBQQ0kgYnJpZGdlcyB3aGlsZSBpbiB0aGUgRUZJIGJvb3Qg
c3R1Yi4NCj4gQEAgLTE0NjQsNiArMTQ2NSwxMCBAQA0KPiBub3ZhbWFwOiBkbyBub3QgY2FsbCBT
ZXRWaXJ0dWFsQWRkcmVzc01hcCgpLg0KPiBub19kaXNhYmxlX2Vhcmx5X3BjaV9kbWE6IExlYXZl
IHRoZSBidXNtYXN0ZXIgYml0IHNldA0KPiBvbiBhbGwgUENJIGJyaWRnZXMgd2hpbGUgaW4gdGhl
IEVGSSBib290IHN0dWINCj4gKyBlbmFibGVfYXBwbGVfc2V0X29zOiBSZXBvcnQgdGhhdCBtYWNP
UyBpcyBiZWluZyBib290ZWQNCj4gKyB0byB0aGUgZmlybXdhcmUsIGV2ZW4gaWYgdGhlIGRldmlj
ZSBpcyBub3QgYSBkdWFsIEdQVSBNYWMuDQo+ICsgZGlzYWJsZV9hcHBsZV9zZXRfb3M6IERpc2Fi
bGUgcmVwb3J0aW5nIHRoYXQgbWFjT1MgaXMgYmVpbmcgYm9vdGVkDQo+ICsgdG8gdGhlIGZpcm13
YXJlLCBldmVuIGlmIHRoZSBkZXZpY2UgaXMgYSBkdWFsIEdQVSBNYWMuDQo+IA0KPiBlZmlfbm9f
c3RvcmFnZV9wYXJhbm9pYSBbRUZJLFg4NixFQVJMWV0NCj4gVXNpbmcgdGhpcyBwYXJhbWV0ZXIg
eW91IGNhbiB1c2UgbW9yZSB0aGFuIDUwJSBvZg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9maXJt
d2FyZS9lZmkvbGlic3R1Yi9lZmktc3R1Yi1oZWxwZXIuYyBiL2RyaXZlcnMvZmlybXdhcmUvZWZp
L2xpYnN0dWIvZWZpLXN0dWItaGVscGVyLmMNCj4gaW5kZXggZGU2NTlmNmE4MTVmLi5jMzNiYjk4
YmY3OWQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvZWZpLXN0
dWItaGVscGVyLmMNCj4gKysrIGIvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi9lZmktc3R1
Yi1oZWxwZXIuYw0KPiBAQCAtMjAsNiArMjAsOCBAQA0KPiBib29sIGVmaV9ub2NodW5rOw0KPiBi
b29sIGVmaV9ub2thc2xyID0gIUlTX0VOQUJMRUQoQ09ORklHX1JBTkRPTUlaRV9CQVNFKTsNCj4g
Ym9vbCBlZmlfbm92YW1hcDsNCj4gK2Jvb2wgZWZpX2VuYWJsZV9hcHBsZV9zZXRfb3M7DQo+ICti
b29sIGVmaV9kaXNhYmxlX2FwcGxlX3NldF9vczsNCj4gDQo+IHN0YXRpYyBib29sIGVmaV9ub2lu
aXRyZDsNCj4gc3RhdGljIGJvb2wgZWZpX25vc29mdHJlc2VydmU7DQo+IEBAIC05NSw2ICs5Nywx
MCBAQCBlZmlfc3RhdHVzX3QgZWZpX3BhcnNlX29wdGlvbnMoY2hhciBjb25zdCAqY21kbGluZSkN
Cj4gZWZpX2Rpc2FibGVfcGNpX2RtYSA9IHRydWU7DQo+IGlmIChwYXJzZV9vcHRpb25fc3RyKHZh
bCwgIm5vX2Rpc2FibGVfZWFybHlfcGNpX2RtYSIpKQ0KPiBlZmlfZGlzYWJsZV9wY2lfZG1hID0g
ZmFsc2U7DQo+ICsgaWYgKHBhcnNlX29wdGlvbl9zdHIodmFsLCAiZW5hYmxlX2FwcGxlX3NldF9v
cyIpKQ0KPiArIGVmaV9lbmFibGVfYXBwbGVfc2V0X29zID0gdHJ1ZTsNCj4gKyBpZiAocGFyc2Vf
b3B0aW9uX3N0cih2YWwsICJkaXNhYmxlX2FwcGxlX3NldF9vcyIpKQ0KPiArIGVmaV9kaXNhYmxl
X2FwcGxlX3NldF9vcyA9IHRydWU7DQo+IGlmIChwYXJzZV9vcHRpb25fc3RyKHZhbCwgImRlYnVn
IikpDQo+IGVmaV9sb2dsZXZlbCA9IENPTlNPTEVfTE9HTEVWRUxfREVCVUc7DQo+IH0gZWxzZSBp
ZiAoIXN0cmNtcChwYXJhbSwgInZpZGVvIikgJiYNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZmly
bXdhcmUvZWZpL2xpYnN0dWIvZWZpc3R1Yi5oIGIvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1
Yi9lZmlzdHViLmgNCj4gaW5kZXggNjg1MDk4Zjk2MjZmLi4zYmU0YjUzOTM4MTIgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvZWZpc3R1Yi5oDQo+ICsrKyBiL2Ry
aXZlcnMvZmlybXdhcmUvZWZpL2xpYnN0dWIvZWZpc3R1Yi5oDQo+IEBAIC0zOSw2ICszOSw4IEBA
IGV4dGVybiBib29sIGVmaV9ub2thc2xyOw0KPiBleHRlcm4gaW50IGVmaV9sb2dsZXZlbDsNCj4g
ZXh0ZXJuIGludCBlZmlfbWVtX2VuY3J5cHQ7DQo+IGV4dGVybiBib29sIGVmaV9ub3ZhbWFwOw0K
PiArZXh0ZXJuIGJvb2wgZWZpX2VuYWJsZV9hcHBsZV9zZXRfb3M7DQo+ICtleHRlcm4gYm9vbCBl
ZmlfZGlzYWJsZV9hcHBsZV9zZXRfb3M7DQo+IGV4dGVybiBjb25zdCBlZmlfc3lzdGVtX3RhYmxl
X3QgKmVmaV9zeXN0ZW1fdGFibGU7DQo+IA0KPiB0eXBlZGVmIHVuaW9uIGVmaV9keGVfc2Vydmlj
ZXNfdGFibGUgZWZpX2R4ZV9zZXJ2aWNlc190YWJsZV90Ow0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9maXJtd2FyZS9lZmkvbGlic3R1Yi94ODYtc3R1Yi5jIGIvZHJpdmVycy9maXJtd2FyZS9lZmkv
bGlic3R1Yi94ODYtc3R1Yi5jDQo+IGluZGV4IGY4ZTQ2NWRhMzQ0ZC4uNTY2MTE4MTk1ZjkyIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL3g4Ni1zdHViLmMNCj4g
KysrIGIvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi94ODYtc3R1Yi5jDQo+IEBAIC0yNjUs
NyArMjY1LDggQEAgc3RhdGljIHZvaWQgYXBwbGVfc2V0X29zKHZvaWQpDQo+IH0gKnNldF9vczsN
Cj4gZWZpX3N0YXR1c190IHN0YXR1czsNCj4gDQo+IC0gaWYgKCFlZmlfaXNfNjRiaXQoKSB8fCAh
YXBwbGVfbWF0Y2hfcHJvZHVjdF9uYW1lKCkpDQo+ICsgaWYgKGVmaV9kaXNhYmxlX2FwcGxlX3Nl
dF9vcyB8fCAhZWZpX2lzXzY0Yml0KCkgfHwNCj4gKyAhZWZpX2VuYWJsZV9hcHBsZV9zZXRfb3Mg
JiYgIWFwcGxlX21hdGNoX3Byb2R1Y3RfbmFtZSgpKQ0KPiByZXR1cm47DQo+IA0KPiBzdGF0dXMg
PSBlZmlfYnNfY2FsbChsb2NhdGVfcHJvdG9jb2wsICZBUFBMRV9TRVRfT1NfUFJPVE9DT0xfR1VJ
RCwgTlVMTCwNCj4gLS0gDQo+IDIuNDcuMA0KPiANCg0K

