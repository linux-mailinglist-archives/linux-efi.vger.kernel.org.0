Return-Path: <linux-efi+bounces-6212-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK/3KDLenGl/LwQAu9opvQ
	(envelope-from <linux-efi+bounces-6212-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 00:09:38 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CA317EE7B
	for <lists+linux-efi@lfdr.de>; Tue, 24 Feb 2026 00:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 798E1302E1EC
	for <lists+linux-efi@lfdr.de>; Mon, 23 Feb 2026 23:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6313A37D132;
	Mon, 23 Feb 2026 23:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="t5dYP7Me"
X-Original-To: linux-efi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013029.outbound.protection.outlook.com [40.107.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC487DF76;
	Mon, 23 Feb 2026 23:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771888106; cv=fail; b=i2FZqs2IB2IRk7/jMJ1TowCnr/B7lynWoEw66V9h2CDCXvHsumECC2nXnfb2TG74w2ZoOR9JHUyoB93edQNPTEYIa1v1l3v0wBLqgQ+ROm5dDTVpxCRrpx7TjB5TYnrHl8YGQwNq92/6TaUT3J4UdA9lCxmjfDGarupftH7SBn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771888106; c=relaxed/simple;
	bh=uebCgnr+5e2PZQ6sJjw7i0eQQfTJ4lAqvwrBUrZgSt4=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BoVKnMUy4Zg3WIe8jMpK8fDZOAjCZL7C3dLk/7MfoT9jbrMcA50Gd9PXLk2NnFNGXyRATh8vluC0RgQMkqhaAaU/aFmMPJJ4t7w6Y+tdm9KQXO7YmBFCB0itcBZwYZ7imfsUOqnQCSPYZgnBVKYWU0AylvIlH8XkofmNPqQw3KA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=citrix.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=t5dYP7Me; arc=fail smtp.client-ip=40.107.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=citrix.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGjBVE8nXLhkSuw87Yzqy7NS5yQMbRPJ7MZR3sQqoeENhYl30m/j2cDNMHERNTs82UFRSRfcdzNVn/0NOSbWgpxxbvofzuZ2KzGLCJVbqZpUhMGFjs91gadcay8FJMrjNpkpnTU2seYL0nT9wk4pe0lZJ1W0NXePV7Tq2H0o7qE/aupqT2/h0/iKG6jBFvC2oGLyCxWJj7yq4BXpSo04KIw/zanDOu5yWF5H9eNb0knJfrDG+iDG/DyfRs3D0M0BRbsQabzA7Mi7t6cREVp394n5jiIlp5IJpsp1muJw0mVBV4vs7nv0BE1mUsT6RHuXchfBUoYlDPRI+BDlR8T/5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLnhh1bX8ifl+cTx/fiBs7PM+4kPn1+YIeJaFHd//D8=;
 b=vWgt7rzkKqjOLAwWYg5qohhuGmyRMvBtXKsciMbOLYqhveiL8J7ZxVw818CnIpjQjaV21FpgAiJx8tLU/n2zbQHe9SuJsh0hYzAYuap5aPGXSXyiflM0LVrLBK4eFVC6bVWiDZwIdLReF6g6eU0mmdPMp2XOJ7mT4OpuI9e6336TGyYBwRjc1xPQ9BL0tn6ty840l2kHPpdrZsY8n3mQXKwF9KeJdsCVVljTbsSQPBaR5bGTU8rHNU2Db8cSzobUioH1FZmAWDD9fNT8UdOXVUsfb1ENnqHNdq0eBE6yqyJH82pAWAF4ZIX9o06/6UuEx+i2fKqM1UMoqSxM/uvNBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=citrix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLnhh1bX8ifl+cTx/fiBs7PM+4kPn1+YIeJaFHd//D8=;
 b=t5dYP7MeYHebXTVfTgbMZy8jh8pnz4ms6J2V2VKLiZWMyOUiKxF8k6ApPW1F03b4++cealyRFSAYRSpnbaYmGHdcrxe1FDtvQUB2R9dln4D94oHcKEHbtP9r10rgWtUZ8uuKW2PSxwINHfzJ/i61gMFD7f38ZJYsedg/5Fn1H0A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from CH8PR03MB8275.namprd03.prod.outlook.com (2603:10b6:610:2b9::7)
 by CO1PR03MB7985.namprd03.prod.outlook.com (2603:10b6:303:273::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 23:08:21 +0000
Received: from CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37]) by CH8PR03MB8275.namprd03.prod.outlook.com
 ([fe80::a70d:dc32:bba8:ce37%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 23:08:21 +0000
Message-ID: <02e6a889-ff72-4c18-b9ee-35fcef3570f6@citrix.com>
Date: Mon, 23 Feb 2026 23:08:15 +0000
User-Agent: Mozilla Thunderbird
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
 Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "H . Peter Anvin" <hpa@zytor.com>, dave.hansen@linux.intel.com,
 Matthew Garrett <mjg59@srcf.ucam.org>,
 James Bottomley <James.Bottomley@hansenpartnership.com>, peterhuewe@gmx.de,
 Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
 Andy Lutomirski <luto@amacapital.net>, nivedita@alum.mit.edu,
 Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
 corbet@lwn.net, dwmw2@infradead.org, baolu.lu@linux.intel.com,
 kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: Ard Biesheuvel <ardb@kernel.org>,
 "Daniel P. Smith" <dpsmith@apertussolutions.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 Eric Biggers <ebiggers@kernel.org>
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx>
 <281c3bb3-13f6-47a2-9a9a-134e397bf686@apertussolutions.com>
 <c9a0cd9f-17cb-49e5-a411-b78ef9c7e35e@app.fastmail.com>
Content-Language: en-GB
From: Andrew Cooper <andrew.cooper3@citrix.com>
In-Reply-To: <c9a0cd9f-17cb-49e5-a411-b78ef9c7e35e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0308.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::7) To CH8PR03MB8275.namprd03.prod.outlook.com
 (2603:10b6:610:2b9::7)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR03MB8275:EE_|CO1PR03MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa165ad-2093-4c5c-0d13-08de7330708a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nm5Ca1YvOHptbnNuZWRIUVVreElYTkdSR0FQMWl2R0xXcmxXRVpxVGpEOThJ?=
 =?utf-8?B?YnVLT1c0aTE1dHNZd00rc3I4czM2UlpGZVBjekR2M1ZtS2Yxa1hJL3Uwdk1C?=
 =?utf-8?B?MnI5azhHZkl3MUxPeHVjcU44TVRaTzZXcUdaK29OTzh4T0lZL24vdXhDaDdl?=
 =?utf-8?B?TUcwcTU4SSttTTN6VGVaKzJuQjdIcEwzSHVETk5iSjgzaFdNcUJMd3kvUGRC?=
 =?utf-8?B?L2d4NnhXSTBKd1MwUDg4cDFTYlRHcU5LMmlJNTIwQzdyNXhrYXA3ajFQRlB3?=
 =?utf-8?B?WlBiaXNJT1k0a0lFbEdkemFaL0doYmQ2RGZYRGF1eEdZWUxzQWpseWhtVkJm?=
 =?utf-8?B?NGhWT295TE1xd1NCMmgyaVROSUdGVjFialpkWUpzaVVsTitQRW8vUE1SVGNC?=
 =?utf-8?B?TzhEbEFNWXltclpKbkViZElTdlJSZHRwbFp0WnpQNGFnN080dzRWK25rcWdl?=
 =?utf-8?B?ZVhWOFJ1bGJrZGlzaVpuNWh3cVpLWit5Smp0cDlHLzMrV2EwOFAxOVFONjgv?=
 =?utf-8?B?bkdiZVZjaSt2Sm1KcTVVTnk5TTU4a0w3QVpoOVFNY0lybFRXVHNSS0NNSTM4?=
 =?utf-8?B?T0FNL2pOb0pmeUNPc0FuT2tSNTRkYWRCQ29kK3BMOU1PRlY2YmJrQzhKUzJF?=
 =?utf-8?B?N2JIN2xYdGd4UGlWYmJDVEsvaFJ0OTF6WjAyZGFvZ0ZhY2pWYmNwbkZkb3Jm?=
 =?utf-8?B?bTNpWERkeUtUYTFQQ1A4MGRqMXNhaFgrdGtvNGRXWXVOekhjN1k4bmdzMDlr?=
 =?utf-8?B?Z09WNXM2QVR2NGp6c2N6alhnMFpmWGhFWHBoVkl5Q0pELy9QRFg3b3ZKZzBU?=
 =?utf-8?B?bnVNcjJIYWZ6UjZPd21GK2FodlJ2cHlYZFpWcUJPSFErWm5nbTMxQmZ0MW90?=
 =?utf-8?B?Q0RvUHlnNjVyYW5WMU1TMkhnZlE0QWU0Rm5MZ0I2NW5YZWtBTVpXaEhDVWE5?=
 =?utf-8?B?Lzl1cWRrQlRPTVpJRkhGRzdGa0ZqMkJIbXlLYTNCVzRiK3RETWk2WEdUMjVn?=
 =?utf-8?B?V0h4cWx4RkU2TS9qUXg3UjRxZ2J1RkdnVU9OSTNWM21ncDZWNnFiWHl4USt5?=
 =?utf-8?B?SWNJUXF0NlU5V0dTNVYwd0E1YVNCMll1OVRaSW9PUlJGZHJJRFdtaG9PUXM0?=
 =?utf-8?B?NUFJQklGUnl1RkhOMmVONHdIVmtmSVBKQzNxdmhBRXNpOVVuTmpGRUV1OXMx?=
 =?utf-8?B?bzBUcHNWYnhUU28zdXozcEplYys1WWIwa3Y0enhkaFRaeE9KRC8ybGJCWjdT?=
 =?utf-8?B?WGxBT25tZmpXQ0pSRjFDWGx1YTl3c3ZSNVJ3Uy9MYWZuTVo0SjVsZk9tM0VF?=
 =?utf-8?B?TVFWS3pBRGpoeHNPSW9uZVIxWTJBMHpmWHNZb0FMaHM2bUR1QkVuUjlvTjdu?=
 =?utf-8?B?dmcxZk1ScnJSUmc3VlR6RldqYnBZTXBHMGhKSGVvb3l5Z3Q2c0lmdk9NNHNh?=
 =?utf-8?B?NTFBVTRTUzJPcHl1aWplOW9OSExTb0ErSlhIZGF4UDZ0VzB6dm51OTFTSFRF?=
 =?utf-8?B?bEJEc1pDTjlGNVlPSUZRM2dYMzBWMVhIRlpYRGVJTWw2MzdFeW9qOGY0M2t1?=
 =?utf-8?B?bVdzWWVJRHd3WXRpQW1zVUx4cloxMkxlUjBzbjVCblJnZ1dQT3VzeUx5dkZN?=
 =?utf-8?B?MDVkTUpSTDl4NFllWEJVTFBSbDZkN1JrbUx4TGRLSTZodG1RWklXeVc5eXNJ?=
 =?utf-8?B?RnkxOEFhUmlzSXhaMXJuVkhhZ1dnWHVsZFk4TExCeFNNTzF5R3lFUVRzNklw?=
 =?utf-8?B?dkZ0SldRblhlZXcreFhTNkpBOWJKNjhZOXp2dy9oYWRvczVCL0I1d3FFZGpq?=
 =?utf-8?B?ckJZNGhmYWJRL1dYZFZ1Vmx0TWhoS2VOTHZ2akEzYlhxM1pnVWtEWFVHNm96?=
 =?utf-8?B?Zk1NUklzcWUwZTU5RUdWOStVZ1pDcGZjK2ExRCswU3NGcFREWFpPYnJnMTF1?=
 =?utf-8?B?OExmTjhGUHNJVGpSUnF6eWhqV0UvbVVIa20vYmUydFR5TkovcFgzTC9qYzlN?=
 =?utf-8?B?Q295eWxOWGU5bGJ0cmRIbkNON0UxeG93SUwxNjBGZVk0NEo5VFUwZkxXckp6?=
 =?utf-8?B?ekhBUnhWNFlibmE5S2p1TzdXclljK3crWGhKSWhydUlQblgxQWZIbk9RNWJO?=
 =?utf-8?Q?3ZME=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR03MB8275.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVNXajRzTWYrK0VqNHFmQlZISEJ6c3BNYVRmREtHN3dkaG85ZDI1RDdLZEl0?=
 =?utf-8?B?eWtXdTFuaEpzR2lienA1Y3BPL0N2N0d2QXpZdWpyd2tidGlVUis4RW1yazBj?=
 =?utf-8?B?MUZjT2szTExOcjh0bWtvZG9oZmRUOVNSV3NFT3pmNjR5Sm16cm5hajA4eG4y?=
 =?utf-8?B?bEx2b0NxeFlheEhiM0RXbFZqSW1aRnljb1ZmQ0R2S1NJZEZVYTRyc3krVmto?=
 =?utf-8?B?RWZwdjlrbndHblNsMXc5SHdFVUlsZTBRT3VRL2FEOFA0c1BheUVmYmZxSW9C?=
 =?utf-8?B?WFVnNGVkWGsrcDdDbGovQzl6eDN2QVdCMnNWemNOUE9JL1JxVGpxNTRtZkZu?=
 =?utf-8?B?NFo2M2IweWVFV3Z0S05Vbis3VWFhMnpyeFBtbjRhcEhiRCtSWGk4MEE2d1lO?=
 =?utf-8?B?SjVqSmRTWDJrR0g4eVRnZXJmR29TWVFjZlhOUElZQXBqV2gxSWlDZHdOYWE0?=
 =?utf-8?B?ZllJTkRsNi9CV1ExSk9vU2g1aWN5eFNJNkRUUXMrbW9jZTdvQ2Flam4veXBN?=
 =?utf-8?B?MEJwdGQweGJDVDd2c0VEc3dvcytBQ0VuVitUVEhzZ2JLbkNTS0VYbzFrb3o0?=
 =?utf-8?B?V2RERTRnVzBYQURpRkJkQnJHK2I0OWxKK1psRHNNQmN0c0VZSmRzb2xSRkIz?=
 =?utf-8?B?TCtlM1VMQUxGV0hYT21pcHBKTHJMUk1PUS8yUzM5OSs3dmNvOGpCaDhsTWYx?=
 =?utf-8?B?M21tZUpSOEJWSlFzNVlFMHZad21za1ZpUW5ZM0FOdFlPMnJMWk9IeW5nMHNj?=
 =?utf-8?B?TVA3MGxLaWFId0h1Uy9iSE1JbGxEd01PYTZuVytkdU1GYm9Ecklab0d1U0FC?=
 =?utf-8?B?WXY0L2dFZ2RLb0V2emJJcHJNbjNLQ1IwZmFSQ00ycEptcGIxQnR0a0pGWnhR?=
 =?utf-8?B?WGdmZW1BYXhYNTRwUTRLdHBjS2k5UnNjbDE3c040aFRtdFVhR1h6NG8xT0l4?=
 =?utf-8?B?bVl4YnJOTlFzeDNtQ0RQYUMwVWZtR1dKN3hXVGNkeTNINzFSMnNzM2FpVkEy?=
 =?utf-8?B?ZVI0Ri9SOExVTTBjeWh4WVVoTlZIZ2oxVXNlWHBnaG5kTWYxVG1RaU52OVlX?=
 =?utf-8?B?dERZdW1wQ1FWUUdCTHFRYUFocWY4V0s1NVlERHpDUVlwVUd6SjNFTFFyRjZz?=
 =?utf-8?B?TXFabzdsV04yQXNaSWdocjdwajYxdGpuTnhlYXJDMElBczRKRXFOZ0FJUW1i?=
 =?utf-8?B?dWs2eVNsSjY5WnBZVC9DWEg0UlJhTFVCNnNZNkFlbUFrTllyaEdhUjlNOTE5?=
 =?utf-8?B?cVNnVWVtTDlrcUYzOEppL3N2Mk1VdFh4WEFNWVUvNnd2ZXRpeU00M3RtdW9R?=
 =?utf-8?B?dEpTdjBrdzZVR0U1MGNBNjhPcjkrUWY1R1c1SUhQckt6VFMrMHAzS0V1QitE?=
 =?utf-8?B?UnVSVmRadS9SOVF6KzBWbk5HUXZtMXpIYXNVREtGVXdFT1kvNndXdCtvWmFl?=
 =?utf-8?B?ODNSRUEzRUZOOFVpc3hVaVMvc1lHSmlvSmNSMnhnWjZYbWtnQ1ZlSUMzVnpF?=
 =?utf-8?B?aWJnNGc1QlBiZlV3Z1NQbFd4MythTDhHMGN6VGdqaFhiNWl2Tm1YSUZZMDN3?=
 =?utf-8?B?WmxNWHFIZDRYN2FpakpFaFlCOUpaZ1F1YW9DM1g3blBRanhGVjRLRzBXQ0lI?=
 =?utf-8?B?WFhDR1R6NWhtK1lFbzZLWlg5Q3JIYzNCZXdPN0xuUy9VLzQ4OHQraFpreHRO?=
 =?utf-8?B?Tm9UeVVZUHZFWklWSjgrZEhTSktCcFNPd2NTSXRQWUtDeEhRc1czeS91RUQx?=
 =?utf-8?B?aG5tYUpJeVJoRUZFWGFGOWowYTFJN0g0YXZHc3RIYzFLL0hZOXhabm5IUE01?=
 =?utf-8?B?am9jeFJXREVhdC9tNEpZRmRjbStUZFVoUVBDN1lRUzFnNFVjU2xVRlZMcDNW?=
 =?utf-8?B?d00vREpONFpKRm15YkpjYjVKVS80Yi9nWFFydGtEZ0xncXFlNkxmRm5YNjNp?=
 =?utf-8?B?Q2VmUGRGT0hpT25tRnptalYrbmZvMTRUdnJpNHdES0JWdzhnVUcxYkNHZEtG?=
 =?utf-8?B?Q1BveFhSOUlKNEN0Wmc4UHcwWGZKTVdBZlcxeUE2MTFLMTR1MTlJUE56anE4?=
 =?utf-8?B?NEV0SGRWWHdWaHpRdno1WVJqTzk3cDVRWTdWZ3ptYnJmWkY5MnR6YlVMTmtZ?=
 =?utf-8?B?Qm1UNFZkY0FqRVdvbmVGSG5NZkpRRUlmZkxmNUJwWXdUM3VXbDREUFptY0lV?=
 =?utf-8?B?d0JibzhlTU9rUEFQWWtHZ1hUTjk0WHZnVWwvbk5VRmRKK3lNeWtoMnRrL2s3?=
 =?utf-8?B?cTlRNmNxMHBoNGVKUTRqVkc4T01Gek42YVNBUDZVMUdXeDRWM0hyNlNRanQ4?=
 =?utf-8?B?RkNxa0drNTlLeFd6emEvUXgyTndhR3h3eE1OR0xpTTRDVkQrWlcveDVISVVH?=
 =?utf-8?Q?lXfvv19DB+c4LRa4=3D?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa165ad-2093-4c5c-0d13-08de7330708a
X-MS-Exchange-CrossTenant-AuthSource: CH8PR03MB8275.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 23:08:21.7637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqsQiCZojkXaADdSkp+XTrKfMygXpKjhJpsjT0KHy2pqNzyhrM1T5rCzqZq4CgF3LjWE7EeyMqNeyc7inLEvtw+MZShZVAEmdUsWge6XER4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB7985
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[citrix.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[citrix.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-6212-lists,linux-efi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[citrix.com,oracle.com,vger.kernel.org,kernel.org,lists.infradead.org,lists.linux-foundation.org,redhat.com,alien8.de,zytor.com,linux.intel.com,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,infradead.org,googlegroups.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew.cooper3@citrix.com,linux-efi@vger.kernel.org];
	DKIM_TRACE(0.00)[citrix.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-efi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,citrix.com:mid,citrix.com:dkim]
X-Rspamd-Queue-Id: D8CA317EE7B
X-Rspamd-Action: no action

On 20/02/2026 3:35 pm, Ard Biesheuvel wrote:
> Coming back to this old thread after having spent some time playing with the code:
>
> On Thu, 22 Aug 2024, at 20:29, Daniel P. Smith wrote:
>
> <selective snip>
>
>> Another fact to consider is that the current Intel's TXT MLE 
>> specification dictates SHA1 as a valid configuration. Secure Launch's 
>> use of SHA1 is therefore to comply with Intel's specification for TXT. 
> As I understand the Intel TXT spec and the code:
>
> - TPM 1.2 is no longer supported by the TXT spec (since 2023)
> - TPM 1.2 is not supported by your GRUB implementation
> - in TPM 2.0 mode, SHA1 is only supported by the TXT spec if it is the /only/ algo supported by the TPM
> - the proposed kernel implementation ignores any SHA-384 and SM3-256 PCR banks if they are active, and caps them using a { 1, 0, ... } fake digest.
>
> So apologies for being slow, but I still struggle to understand why it is so important to have a SHA-1 implementation to cap those PCRs. Is it just to support systems with a TPM 2.0 that only has SHA-1 banks enabled?
>
> Assuming that this code will get merged this year, it will be in a LTS branch by 2027, by which time distros like Debian will pick it up. 
>
> I fully understand that this code has lived out-of-tree for more than a decade, and you likely prefer to get everything upstream that your current users may be relying on. But for Linux, this is a new feature, and merging code now that is basically obsolete on day 1 is not something we should entertain imo.
>
> (and apologies for re-opening yet another can of worms - I assure you I am trying to be constructive here)
>

I appreciate that you've got concerns, but I don't think these
characterisations are fair.  Ultimately yes, we do want to support TPM
1.2 systems because we have users wanting a way off the out-of-tree patches.

3-year-old hardware is new enough to still be in full support from OEMs,
and totally fair game for distro LTS's even at this juncture.

The TXT spec does not speak for what OEMs choose to support, nor for the
TPM spec (where SHA1 is a mandatory algorithm for TPM 2.0), nor does it
speak for other silicon vendors we're trying to support (there are AMD
patches waiting for the interface to stop changing).


But lets ask the question the other way around.  What does refusing SHA1
gain?

AFAICT, there's no meaningful reduction in complexity in the early code;
the TPM library speaks TPM 1.2 and 2.0.  There is a small reduction in
binary size for not including SHA-1, but including it is no extra C
because we reuse the library that already exists.

The cost is a failure to operate in some TXT configurations that exist
on in-support CPUs, as well as older systems.

~Andrew

