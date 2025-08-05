Return-Path: <linux-efi+bounces-4515-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4E9B1BA4A
	for <lists+linux-efi@lfdr.de>; Tue,  5 Aug 2025 20:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 377483BC2B2
	for <lists+linux-efi@lfdr.de>; Tue,  5 Aug 2025 18:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE4B29B21D;
	Tue,  5 Aug 2025 18:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="K4yvnX4K"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2090.outbound.protection.outlook.com [40.107.236.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AA929A30A;
	Tue,  5 Aug 2025 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419028; cv=fail; b=nPzxrdXb5AloRxNYdh7bBR1dlSQJxKg5stOcE8DMQzdUF0aemB5S9TFlSfLqWvIQC3ds6TniIGjtaxEMzLIX0PKDwXVN4DbLg1iFrm3r19TBjSd6YTCUhs9AlTeFi/g7efkud7E4PtMM8mWy0kosSgJHA7/dUmpbgqxasCCw7Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419028; c=relaxed/simple;
	bh=W9uCxRmXFi4I4ZipftyIxfEBg9sBVDNykOu0JSV8rGE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VgPepJBZZWQeSBvm5aUpS88T6rYfhjsw/Ru6hx6VdW2yCT7gfjbJ0ZP7lfq+Ke5MdqijGVa/XAIXAa1/6t2ziIBfUXTdtB5ShFdBCM/bIWUfQxwbnXLM6NdSlJLM9+v/8p1o5ScUm9KOjK74fp0ihVFLbhF8WB+A7OKU/kWcwb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=K4yvnX4K; arc=fail smtp.client-ip=40.107.236.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGKotphHj7KpuAdyXJKNbf969UM2D7FiSBfbg0Bg4oWamLkknUNjnCDKfgQjyHXfPp/NV59amqsuOSFliHPfpDR29YK0qY8TWEOTZP+W4UG+HX+eFdJT58+TNuNTpk1175Kvp8a4tv8F3x52pKGQcfvgccButhOXmCIiTeX9Rjj+6TbJpyfTANOfqFHwQAWi3kr2qIeaUd5ep3fvj1hMP3Ktl4iBqkereKV82498Y+xgCObheRHHg/KNmnDB/u5/CQv1H9ucRbQVG2t2wCGHkk2Sm4CPWjteVqIqm5KQNZD0Lb4kLb9HYjXiFKeEcsWPRFCzHte0QS96a9dCJKTXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JDPdh5/KZZhUE9C8eI1j3GemRKaQ4CISdV05oe41s8o=;
 b=ouEQwWnOqbprElkhcXr+umH4G3i3nmbEZSKQ8R03BJsvuQhD8WEZ/DhUfn9XHDTnEVPgg02kLmceBkWFDJtdc/OKGmshJZ45LGNt0PWaAvucI/VmtLzomP9ysiCl1COwHioLtEsDInJdnPp+LAqGV8nsqiaNluQ5OhmR8J3NAQ3ZKSttBQYJsmuv7WkW4Dlc7QH/tpyvcEAgX7A1pAEHA76eMeg+ZTY+wrKEKn562Ycl1av2kA2ezpMFpvKIUQYX613lQxOsIZgWlYUaBcNvkJN99A+sYO2lRxQrQr31XlljyFuEkL9eIceCWVS1wnJ9iAR1CXjLyEQDAylBaL2B6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JDPdh5/KZZhUE9C8eI1j3GemRKaQ4CISdV05oe41s8o=;
 b=K4yvnX4KPKTjH1rGeWhAja426LqJj/OwbrIdQ14V31OrwuSQCWIdXx90hIxGn38m5F/VhMmHHbM5jRzSEJal6MbFUUcF8LQOzNUX0DZrR0eMiwVuUvXrn3rSdfiUfVhU2vsDIwGZT0+//F/X2qaSIA4aW5oRJ5cFH1QRPc+LiJk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA3PR01MB8473.prod.exchangelabs.com (2603:10b6:806:397::12) by
 MN0PR01MB7755.prod.exchangelabs.com (2603:10b6:208:37e::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Tue, 5 Aug 2025 18:37:04 +0000
Received: from SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3]) by SA3PR01MB8473.prod.exchangelabs.com
 ([fe80::46d7:1d3a:dc9c:69c3%6]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 18:37:04 +0000
From: Daniel Ferguson <danielf@os.amperecomputing.com>
Date: Tue, 05 Aug 2025 11:35:41 -0700
Subject: [PATCH v4 4/5] efi/cper: align ARM CPER type with UEFI 2.9A/2.10
 specs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-mauro_v3-v6-16-rev2-v4-4-ea538759841c@os.amperecomputing.com>
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
X-ClientProxiedBy: CH2PR14CA0016.namprd14.prod.outlook.com
 (2603:10b6:610:60::26) To SA3PR01MB8473.prod.exchangelabs.com
 (2603:10b6:806:397::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR01MB8473:EE_|MN0PR01MB7755:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e7ab0d-792d-4308-f7cb-08ddd44f133b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dkJzdGoxR2F1UENuV0U0YmdvY3NFVlJlM2swVExMTEIvanRLU2xxUE8yWmh3?=
 =?utf-8?B?WnlWNDZvQkNBa2ViVmRybG1RNDdaTm5ZWmhEeUxwRloxNVZ2cTF0d0dUTmpy?=
 =?utf-8?B?NlJ3cGM5VXFEOU1HNTJZL2lIZnVsMWtXQzBpOE8vaEZydTcvODRmZGl2YzU5?=
 =?utf-8?B?eHBHUTQ2UDJJK2J3aXljRGRTLzZTeU5aWHUrT1JDaUtkL0RnK0d1VWI2OVJn?=
 =?utf-8?B?MXdXWkxZNys2NzJWV0lnRkhRV3hNQ1BCVVhwYUhXMWpCSmt5RFlxaDllbXQx?=
 =?utf-8?B?OGp2Wm1xUEtxQm9ubnl6cElNR1NCRm4xT0d4QjBuQ1hEbkxVb05DM3kyNURG?=
 =?utf-8?B?NzROTnFiZGxNVzV5ZGRjODQ1WXR3K2pKdUwwUHNvalcydHptWVUvSWpVbEQ2?=
 =?utf-8?B?eXdqUUs4d3B4bi9GT0hJNGZXSlBtTloydEh4Nnc1bEw2S1dBQjJvTW8zQlR0?=
 =?utf-8?B?L0lmWmFqSnkvdDdyNXFCQjZnUkp4Tjh1cnBCemNhZ0hxbVVES0s0MzRKYjdW?=
 =?utf-8?B?K1J2V3FMcUJobjQ4S2Y2YnpLdU4wcDZ2Wmt0L2pSZGQra1BmU2FqM1NYaGh6?=
 =?utf-8?B?K0d3VFBjTmg1ZlRyR0RzcVNwTWdoVVNWYSsxNFNodExXcGNoRmVqOW9iaXk1?=
 =?utf-8?B?V3JGWjVNQXY2ektxdTNnN0tmRXRSM0tRbnA4U1R1aFZOVnNZOFZKelI1YW5R?=
 =?utf-8?B?dk9aSlo0L3hna0doaTV1Y0xOU1AvRzlSczBxQUhZK1A5OUZHcjlLZ2svVlhr?=
 =?utf-8?B?VXpWVk10bkpna3NPanp2SG9oWWNTek5hTmhteGdiUjFMdGxpOVAvRldaTll6?=
 =?utf-8?B?aUtQcndZVmRxUXA0WEM1V2RncDlVdnVCQVZiM1R6UTREZnljRmJOVUVKdUxH?=
 =?utf-8?B?TEsvOFN1WjIwakgyZmdQaHl0OWRsSXJVTHF4dG1Qdzh3QXVONjU3cmJzUGU4?=
 =?utf-8?B?WnE1SnFLamtVWU93eVR3SkdTdGtPMklrUUlFWjByc2xZNmN6b29XZ01yem00?=
 =?utf-8?B?RDdMamdjR2hjM3Z5WERoZ0RFbDE3Mmo2NGl5NTZ0LzI3NFNoVFBSbXcxT3lD?=
 =?utf-8?B?V0haZDcxeU9RY2ZOMk5jZkdkNlN4ZkJ1dlBqcjhkVWFiQUttOVdTLzZrS0hB?=
 =?utf-8?B?TElDaW9pMUVQYW40ZUVjb243ekJ5cnR4VWRqUElYSmJ2NitCUndIRmdlbFB0?=
 =?utf-8?B?NDFsQWlYNy9pZTM1bmhHVzg1YUJ2Q2k1VzBMOFZTZGZhYTlUV05BM3FKQnoz?=
 =?utf-8?B?dXZKc2pWcTFvTHdiMWV0SVR4V1JwdVNDMW5ES1VVZGJnblNLTXJKUkl6aElE?=
 =?utf-8?B?MFhydDY2emZQSTFCSEtCY0dDMi96dkZ6ZkJQc3VTTFlpblVJa0RZd0lxWFMx?=
 =?utf-8?B?OWlqbEhUcWcwbXlvdDBIS0NFQXhDZ05lTWRLS0VCUENVODRGS3JxSVRsK1BV?=
 =?utf-8?B?TzRzazR5bklHQlE4SzZGMjA3cmlTMHNna2svdFlib1U3bkdMSXd0dlk3Nlk0?=
 =?utf-8?B?bnVneG5EVXRaVi9mcjlqS29uRENKVHFabVliRzlLdklqTUw5VUFKQ04yYWFF?=
 =?utf-8?B?WHF0ZTg2a1dQK0JaU2NwUDZpVllxQnJycXRibWVrZjd6THYwV1NueExpdHQx?=
 =?utf-8?B?R0lidDQrMHExU05uZFppOEJHNmpDcjJ3bkNzTXRyZnc3d0FIdWxVTWNUSEk0?=
 =?utf-8?B?TXFxSmN6MHI2SndzVm9wM3ZqQVhVZ09zdGFSUW1ET1RoUjk4RXQzTnJGUHVp?=
 =?utf-8?B?T1lDK1pEOVJlZkp1cXd4anBtNHQ2OXRGOEtiVndVcm80WDFNN2w0TUo3S3ZJ?=
 =?utf-8?B?cy8zWk9uZDVxRUo5VHVON1VSa2MzcFN4SG9pTmVsWm1URE9CbHdmNWZxSXlC?=
 =?utf-8?B?UkZacmlHaHhvclpUU2FjeWVNd0RqYXVsbWcvWTR1L2FRVDNIcmdWdXpKbmRC?=
 =?utf-8?Q?A6IxqeVXrhE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR01MB8473.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3l3YzhmQmpXbUt0TG05S1JGb0hhNHJlNndFbXU2VGphMmh3bS90cUdsejBm?=
 =?utf-8?B?a2taSG10c3dDSVptTStXRHdTQjVDQ0g1VE13UWJaYUcxVEtObWE4K3MxRzFL?=
 =?utf-8?B?enRWajhzd1BZSUpHdEF1U2thSTdpbTlLUVAvOG9MVUFIOWNkcXMxZzhFUlNK?=
 =?utf-8?B?QnlxcGh4NW9zaUVtTG9sNDdUZmZTVjAxN0VPdEN2UnVacE4yZEZTWlpTWHdD?=
 =?utf-8?B?YXUxUWY4Rm5yd3hmTko5MmRLN2VNalUzZTF5cEwyZkUweER3cTNTWmE5WDU3?=
 =?utf-8?B?S3pyWXE2U05LNGRiai9YTThHSHFnTTkzU3c5R0tQd2RqemplNmhkRU96YStz?=
 =?utf-8?B?RFppWUdpU25MU05nSlZMN0g5YWpBU3lCZVdscHFhZXI4Yld3R0N4V3FXWnd1?=
 =?utf-8?B?WjU4ZUFUSDdqOUswVU9NUFkvNldRY096aFVoVzFRQ3d2MUROY3ZCYkk0c1Y0?=
 =?utf-8?B?QWN6V2VJWmtiRDg5NGh2aFhmUGN2SHhDcTNSdnppdmhhWjBqdThDRUs2eEg1?=
 =?utf-8?B?UlRRS1pTc2RBbXpNMkttOU5jckV6eFJxQ3VGSkZPR05TbVVIQUtaNGJ4T3pO?=
 =?utf-8?B?OUp6NW9TY3k3V0hTQlhpem4rMUlnUFV5amczUUdoZVNBMWw1Qk5IK1Nsc0NG?=
 =?utf-8?B?bzhhQnZKL04zc1B3MHcyTEsrQ2gxMEJXMWwrTXR4MzU2Vk1xTHU5ek1pbm9w?=
 =?utf-8?B?NXJEQlI5dGVPTktKZ2F0L0hrTXNSQU5DU2tjWWFWenhzMUNQYloraXN4ZkZQ?=
 =?utf-8?B?ODVRczRnRTRSNmlxaWRkam1BQmt6OS9nOHZoTjlSZExHS1ZFV24vd3M4TWxG?=
 =?utf-8?B?eEZzNzJDelB6UENLTTc4VDNaWDg1Z2tMSmMxWHFlVjlOdk5SV3k1Y0dzNURP?=
 =?utf-8?B?bHFZeXFjRGtOWVVMeEZBVDcyVnBBYzByb1ZGcFhqSUVCT01UZzUyRHYyMm9C?=
 =?utf-8?B?MW42QnNNVDl5ZWJWYTZ3Z3J2cVdXb3I1RnRwQmhFa25MU0VLcmZTVWNjWFdY?=
 =?utf-8?B?SE96L0NqSXNhWGVVTzNrbnZXdHFoSy9neXdnRVA4WS9yd2NYSVhmUUp4SkdG?=
 =?utf-8?B?dEJibjh1cHE2djNXRlo1UzIzM09ZL3VDRXhkM20ySURPQkdaT3RXTHc5M0Zm?=
 =?utf-8?B?ZEhodHZ6NWhnOEpwdk44aythWnRuZFVKWTRMSUFRQ1lCZHlDUElncUpBM2hD?=
 =?utf-8?B?N1cwcjlhRklhdGpjZnFLVFFUdHJUcVlhUEhLVnJNemNFZVhVVHp5Q0hzc2hY?=
 =?utf-8?B?UUF2ekFGTmpVazhYYUtjdFpZd2hJYTB4NVhFMy9FcWxrVnp3YTk1NHg4N213?=
 =?utf-8?B?d2NScXF5NjFZK216UG1kMGQwam1aK3hqcUxKanByMWV6NSsxZE9HcFNCTEsx?=
 =?utf-8?B?a3hmVEhDVXlyM0ptZWFReTNBc0JhcEU4Y1VQc1Y4UURXYzQwajFPTWZEbWo2?=
 =?utf-8?B?MkdZbDhvNmlRQmxFZ0tOZzFOVitMaFVpYXNiMjBRTjcralJWV1huYTNzOXdI?=
 =?utf-8?B?SGFwM1R3aXplaHhuSklJRW9DcDVZbkVXQWJ0bEZoWUkxTmltcGg0MXkvNVR4?=
 =?utf-8?B?YklzdEhFWGthRWI4VFAveXJSTDJIU0NjS1hVWnBHV2ErRW5NNlVRVWwxT3g3?=
 =?utf-8?B?MkJ1cWVNQVlLMVFOOUsyaVZYYnQ1TjNFMEsrRkZaV2FmNk9wS1d1L1h2WTRw?=
 =?utf-8?B?RFd3eGFTM2JDVWVnQ25JQ001K3VsbHYvL1ZyZXB1ajUrVHY5eWZQVnZnT1pJ?=
 =?utf-8?B?UUZPbzd4UU1wankrYjdqVXNtcnozTnlKNGg1VEZzaDlrNkVkTjFWKzNOU0dQ?=
 =?utf-8?B?V09NS0FCckI2RnJhV3lTbUlVcXdoSVdsM1E2VzYzb2RBYTE0eHp2ekVQdXY3?=
 =?utf-8?B?TEs4QlRqUmppUEt4MUlzZE00eGhBUFRkcHFjN1FvWHYyWUJZV1czSW1sSUYv?=
 =?utf-8?B?VFNpNm9qOGZwU1dRRzFZQzlPeGIzbWxFOFdBdytMYnB6OFI1MVNla2p3Yzhy?=
 =?utf-8?B?VFhEMDZQS2ZXK05GOXJIY0RFaXhkUXE5bTQ1TFJwL29xVVgrWTF5MHBGT2xJ?=
 =?utf-8?B?WlpVRXQ1Y0Z3dXF3NTh3WEdSMUNuQzloTjlFRnpiRnM5S2laTlFXem85V1lF?=
 =?utf-8?B?L05Eb2VZdEkxTHF3QTJKaFpSNk11MnpuWU1JVnFzUVZiTkgvdUl6MzBCTUk3?=
 =?utf-8?Q?AxrSRXDrZtDXgv5X0ZzG47k=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e7ab0d-792d-4308-f7cb-08ddd44f133b
X-MS-Exchange-CrossTenant-AuthSource: SA3PR01MB8473.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 18:37:04.8233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhEF4t78nDJAoc94I2EkaUsM5hpnbZvZPekpkyOi3ov6E/8eTttTzKt07sBC7SHU0H0bj6U3uGQlKAno+0RHvUPUjGZI2aMlAi8cuTIdPOqYQB3ZPfivR4Gt9ocmvevZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR01MB7755

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


