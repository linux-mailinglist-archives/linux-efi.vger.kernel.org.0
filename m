Return-Path: <linux-efi+bounces-1619-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ABB9631A3
	for <lists+linux-efi@lfdr.de>; Wed, 28 Aug 2024 22:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A3D282144
	for <lists+linux-efi@lfdr.de>; Wed, 28 Aug 2024 20:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EC21ABED1;
	Wed, 28 Aug 2024 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ouy06tZ2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C9PFnF3c"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855D317C223;
	Wed, 28 Aug 2024 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724876416; cv=fail; b=jZoGlmNCkJxaD2en/deVbw8uhNr3qBVoWQRrJzIrwmNrQSpNeS9oNuBX4ChzJkKb03x7zdxIDfdJ/WiB+Acn1dJKUqeq6pK7kHmLrkvNS4cACJfMrZmLs3y06J7qM0GBo7PKV5ZDoeMoDCiB94bGGyFy8msZ+0hz552mhASBFWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724876416; c=relaxed/simple;
	bh=ikk2fEbtzAmBL6kRGpPBz7UEF4QxDRQvx0SlmpkU8oM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=htfZVkoZv/NK1p7No1I3/cjhKpdxrGzUYojbFj6jV55RgH9Igyh8FY9FujnC10F0xGYWKi6m+BUI7dSGqodKrcUyvZheiqFd+Vna+pgVn8gyxKdbqJma4eYAvWJeYYwiIesPkSmlbE0SczCsz0aQHuBttdk+HsIvpx/Rjc7nbDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ouy06tZ2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C9PFnF3c; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SJYFt0015542;
	Wed, 28 Aug 2024 20:19:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=y/RXTqQnpHH9W3+zzUFtWYO4EK/dO37gh7k0mDlRjwU=; b=
	Ouy06tZ2mmqG8ixLd0D7zwxMj2DkUsXrCCPfkbK7+HT4Yv8nk8ZAO2sosWZHxksU
	HQpKp7P845FK8eCmJIzdzdESb3mfzef6CLRmL3ZB6mid19EyeHa2oEXHX3Uezce3
	9xWu//jYcKDl4sEBCImyeRRhvPH0O2sBrWRgJ+aA67ayoZ3Hfc3xmvbrNzRcf37A
	5gWfz0/gJKF9L4cPDs3wDbB1MpAHmsXGhfkDLvle9B1c2/kEzR+bJsyHMvryEm1H
	E9v1b0VG9eBm5yLdr6I763o2j/5LeQZ0uqNQ094BQnC5qyWGXPFTjtAi++lfKg/M
	CZXDosnoSCg4PEFgGwoxYQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 419pugt9qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 20:19:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47SIhMeH020513;
	Wed, 28 Aug 2024 20:19:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 418j8phwuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Aug 2024 20:19:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZe3or6tVCXc6QtOLqGfWBTw7dT7Ip7Y6PLntNt+gwLN19kcD32CrrV0cSFThpNYxpl+HXiigP0IjfY8K4YcKw2iB/Z5ofWNDYIs5yif0qqR7nWpFk8S61qQJrSP3HimCskXp8v8EsL/n4/Y7kq7KHJNTJ/GazjD76qlpMrLYoWRSjCj/+pRGdoPxOVY8TRnoWMwhOYdz/UC94odHOzXUE6apTdu4V+U+cteREv/fJju9hNuj9e8N2tQuHc4bnqBDAa1rKuEMTrfTfiKn0NCC2b+/G55f5sXdGIe3xF8ZNbzq5Nt3GnvWG/F+uQWE1kNSiXxyJAdw5g7JSNjJipIeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/RXTqQnpHH9W3+zzUFtWYO4EK/dO37gh7k0mDlRjwU=;
 b=A1JMrccdS7J8BeyZBJ0ZIUhC2yt9lpIs/v/4pNxEnF9WDtD6wL7a84zTI0dhb792GqhE6REHStND8jgKVIt2MCZ+8zr4Q5Koq4Eyj+mURAswdjtAXYrjlQgAQo3JclO5GUMBo/pAYoAcjhtK5NyJf/et2xGtLQIGuwfCxa4ANcmWd08+hxozUhLO3s/qSfYCZSsfQNYDQA19SCGkKlelyTqD2g9o5LoA3f7L04aa1oIHV6GCR5GZoIj7DeD3mMiQUiLbFlnIHgxUsDNIQ6xaLtZQPMXltKPtY7kpOrwsxVwTo35PF8nT27lz3hbe+VGH0XkKfreFap1e9AWzLJGWag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/RXTqQnpHH9W3+zzUFtWYO4EK/dO37gh7k0mDlRjwU=;
 b=C9PFnF3cT+GDRUD87rHEKT4ssW/agiLD8gU8hbHHW/uKtiuLA41m4L6Sj4kOj/AhYJwoiX9h/LYxmZDU0np+dHB1kTWUzyZxZCMX3VL2QiBqkv+aZMPIddz5V3ep0l5A+6BEJB7LJkMRn4aJ9hd+aoSewb6wRjW5whYYyrNCmQ8=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 IA1PR10MB6124.namprd10.prod.outlook.com (2603:10b6:208:3a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Wed, 28 Aug
 2024 20:19:23 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%7]) with mapi id 15.20.7897.010; Wed, 28 Aug 2024
 20:19:23 +0000
Message-ID: <6b214ad2-d448-4f5f-85e9-93cd38e0e035@oracle.com>
Date: Wed, 28 Aug 2024 13:19:16 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 20/20] x86/efi: EFI stub DRTM launch support for
 Secure Launch
To: Ard Biesheuvel <ardb@kernel.org>, kernel test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
        oe-kbuild-all@lists.linux.dev, dpsmith@apertussolutions.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com
References: <20240826223835.3928819-21-ross.philipson@oracle.com>
 <202408290030.FEbUhHbr-lkp@intel.com>
 <CAMj1kXGVn85ht_srwhYXDnKffPFX=B2+Cnv-8EAocwoHi__OoQ@mail.gmail.com>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <CAMj1kXGVn85ht_srwhYXDnKffPFX=B2+Cnv-8EAocwoHi__OoQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:208:c0::24) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|IA1PR10MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: bbdaabab-257b-4c39-8ce7-08dcc79eb4c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUNmck1BMFpTMEJZUERyS1BNQzVRaml0YWROZWJscTF3aWFJams0bmlvZ3ds?=
 =?utf-8?B?YVFBbGxiTEd4OEhxU21jdGVXRkNZY28xTFd3NGJGOFJ4aFNOcFBVSnF1ZzBa?=
 =?utf-8?B?cjZwbmUvMzE3czRpN1pPcFRENVplVVZkajlRZ0RxelY4MEpBZWVFd0JEcXlX?=
 =?utf-8?B?NzJxdmJaZ2dLeGpuTlhITG45YXdaWVhsaEsyL1ZNRy9MN0tXVG4xVzVXQjZa?=
 =?utf-8?B?cFR2dUxad3p3YXk2QXk3bU1EZEdYdlNMSmVWL2oxeGhVVElhOUVjVDdjSElx?=
 =?utf-8?B?RjhMY1BVdm9OVWRqRVM5QldXRTU1ZnNMbFBZRkVLWEUxNE1CVU9WUlJZTzhZ?=
 =?utf-8?B?anpzUHNlVzZ3TmtUZlVia0ZUYk1yOE41ZVVXMG5xSHJ3RURXRmRMUkJzaGZ4?=
 =?utf-8?B?bUtyQ3RUUm9XdGdrUk01QzFIbGJhNTlFWFEyeVdzZzNiWnVWdTRCWmpqYlZJ?=
 =?utf-8?B?N1MvN28wUDRzNlpXemJBRmhhNlVhNjdsczNhZnl2Z051dkV0YXE0Ymhqd2FH?=
 =?utf-8?B?VGQveE1EQnhNQm1MOXIvdzhpNSthY1dNV3BacWo3WTZldDFRVW5kRm90T216?=
 =?utf-8?B?aWV2dE03VkdaUG1KWGs3SS85ZWsrUmlWK0NjeVk5Y242Z29WOUF2RjNuVmZl?=
 =?utf-8?B?dVJDMlpKak9XcVVSNDc4enhrRXN5aVRXaGdMM2pTNnUrUFU3Y0EyWTFJSVlB?=
 =?utf-8?B?THpYajBXeDlYa3JBK1RmRkN1aDIxNTgwUWNqYW8vZ3k2ajYzMlQwMmpJdlJO?=
 =?utf-8?B?WDRCbzRncUptUWFJVjJaWFRXWDlYdi8raDF2R0NoOTVXZzVZa3dnREVMT3ZK?=
 =?utf-8?B?ZURDQzcwMlplRXdocHB4RHdvcXVmcVMrcHdIQW1hZmlsY3JyRDFIajNQUXRE?=
 =?utf-8?B?YVFvZjRlMnhGalplSExZT2dZZmpYcEtuSTVsUGpWaTVaaFNHV2hNNEpmUFhy?=
 =?utf-8?B?cUZ3RmRQS3hsdS90dmIyTlczRnhpN2ZCM2JwNkZLcFkzVzFvUUE5UVgrU1J6?=
 =?utf-8?B?cGt0aFlqN2xUaHRlNk5HbXoveUFqR1k2WGhwU2s3N0cxYUR6cDRGLzgyQUN4?=
 =?utf-8?B?ajB3RWZ2NjZBNU1uSm93NmNuVjdpemRRQU55M1c2YnNkVGpES3VlSzFoWDNh?=
 =?utf-8?B?enE4UmlZc1diZW50VmUxekpTdVZLZmhvWWFjRlN2ZDRwb2FodFhyajE3SDJS?=
 =?utf-8?B?Ry9CWDhkcXhZYTA5bjY3elMzQlp6Qjd2N2JtYUx6c3ZaSkFRYnhpOFkwTmRB?=
 =?utf-8?B?V2hURkgxM0VHZ3hwNVpnM2JnOTQvcmVQSlQycjVsdUhsS1FVb0pCUFZQWHZK?=
 =?utf-8?B?NC9RTFBCbGc4TjU4dG14dEFGbTV1aGkycE5mVUlpRWIzUzVmZ3FWajhUN25k?=
 =?utf-8?B?R3VlOERKeU5TdjhLcnN5NEVSNTMydkdwdDNtU05TL01VbklMYnNabDdGZnVV?=
 =?utf-8?B?T2U0RWlmRHhGcVp5MGhFVlhTb2FDWkRYWkM4d1RqNGEvMFNYZlV1S3cyb2VZ?=
 =?utf-8?B?a3F2RUpaOUpleHhnaHpCendqR1F2OFV6UktLRnJYb2ZhS21rSG9ycXlWTHVH?=
 =?utf-8?B?aTdDbHR0SjhGR3Y0QlkzRmJ6UEo4NTAwUm02WjNiRlFBaXFMZnh2RW55bXZq?=
 =?utf-8?B?SjIrYTIyMTFMRDNlczQrZnpQRDdnRkNHQXovN0JwTDhoTXZWaGlzb1N3OVlo?=
 =?utf-8?B?NXBVTHo5ZTNESU5qUWlIK293MHBMS3lHb2prUVdnR1krMjZOenY1K1FLcmlr?=
 =?utf-8?Q?OqcnzXf/0R1cbB6xxRvtZbB6t3hGhYPs76Rn+rM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXo2amFVT3hsOFdaK1ZuWGFreGl3dDhOS2tEaW15S0ZGcFRBNVZua1ZRdGlZ?=
 =?utf-8?B?bGN5K2YwUmJYUUczbDFXNi9FeFEwR0ZCbDZDKzF3Tnd2SkxxUkxXTFlpNkU2?=
 =?utf-8?B?Z0J4WTJFZ2R2VURSYkp3UWZ1SDg2Z2pSSVdpekxuRllZbXJNUXBSZGhEVHpI?=
 =?utf-8?B?b2N4OVNQODRHNWJ2SjR5V25Qay9nVTJQUDdjZml2NWxwaFpSYjhPeExWS2l6?=
 =?utf-8?B?RllPY0x1YyswN0Jnditzc2xNTG5JVVNJeU80ZzVUdWMrVUZ2QW80Q2JPVDU5?=
 =?utf-8?B?OVFZczErSDgyd3p5T2tIYmRwVklNUDdtOExpeDJxYnpKbXN5WnZFa0RNZitr?=
 =?utf-8?B?RGx1TUViL1ZpQkMrU2M0eVowbFdOTkVwaTJJbHFlT2RmdWo4WVJzN1psNG1y?=
 =?utf-8?B?Vm1CNXJxeGhrZDR5Q1JoNXVkTWZQaGpxM0RrNUtzME1HNWhhaWE1aHA3OEU0?=
 =?utf-8?B?dTlBS0EvWVowdXRiaGlMWW5kTU9ieEMyZk1RRm9aWllFYkZtdTFmcllMeWxQ?=
 =?utf-8?B?TjNYcnJpMnFHSmdWMkViRlNEOUovVkRCK0VwR0tjYTR4OUdVRHlvUEF2c2Jt?=
 =?utf-8?B?NXBac3ZpWkU4dzc2cGVjbXlodGczcC9oVllWWmwwY2QrMWZnVGR6aUJiaEFi?=
 =?utf-8?B?MEx4aHpsQnhGRHFyS0pUeEJwcDQwZlRtb1p5ejV3WHRIbEdWbWNzM2wxL2gx?=
 =?utf-8?B?QVgrd2prTmcrNzZuNytXMGg0VE54VytiWUV3b1czSDFacnJqYlcvdTg4SE0x?=
 =?utf-8?B?emU5NDlBcjh5ZW1IcE5nR1FKVDU0ekZLMXhZYkJnZGREakhwQXpXV2s2M2dk?=
 =?utf-8?B?Z3J3YlFvMjdCa2o5YWhyUlp4eHQzWHBMeXo2M0pnbC9CRUo0Q2hFdE1oZW9x?=
 =?utf-8?B?c1h6dk40R0pPa0RPSFU2cTdNWDZmQWlNcVgzUHZTbHhsaHI4RjBvWWNHNWtu?=
 =?utf-8?B?SDNJbFFTMWI0U3lMb2FaMFF3MlVkQTFYcDdnWU40T3dQMk5ZOEFEaG52OXQr?=
 =?utf-8?B?YnRXL1h4UlRMR25xb2xMQjE5clJ3eUU0RGpUblMzZjB0eHZ2VWl4SENseG5R?=
 =?utf-8?B?UTUyaHJzNFFEekc3OGZrMldnNVQrN1MycE12U2ZKTnNOTlJ3TDRnZEpYRlVM?=
 =?utf-8?B?bTJtR2NtN3IwY1ZTUkJ4M2R2eXQvWkRDY1VjT043Zjd6WUFxVDVKK1ZmZTBH?=
 =?utf-8?B?NmdSSGZ1YVExVFpkN0pHVVdFaDBTZkQzU2wvQXFUQlR1UWUwbFlEZzdJTW5B?=
 =?utf-8?B?bmVFc2ZWaStKMjRkRDNONlhYZnBNWjlqOGd1L1AwamdpbHZXTUhCb25VNHNo?=
 =?utf-8?B?ZXg3cHBWSlQxL1ZDVEh3YmpaOGlTZEJHTnpPSGFxSHdJbVhqSGROMTVDMkV4?=
 =?utf-8?B?RjBqVkFRODM0ZmpjNVZaU09sMVAxTUV0NWtBSHEwdkNPOEYzMC8yNzk0OFFo?=
 =?utf-8?B?SWNQQmcvSUkxZEJqTjJrTk5ZVnB5ZHMzREF6cXg0cFhNUVpZRGJaYzZmSnJp?=
 =?utf-8?B?aUJUWjhFeDRTRnMrNEVrK04zRFUxQzZMemxESUxlaUZXUTExL0NCaGNaRndM?=
 =?utf-8?B?b2paYnhTWGhITE1PbFdyV2toTHpVbC9ndFFMM3pWZGFWRFdlUndyQTJtRzdo?=
 =?utf-8?B?TUtzSGtsMnN5eEJUTmZlcFB0MnJPbmllTXZkbU1UT00xbkU3a1pmODZHVS9v?=
 =?utf-8?B?SUwxcDR2Q3psM3hidU1hZm1zZXl5ZjRSZ29jWmF3UHlaeWd6WUVzaHZQcWFm?=
 =?utf-8?B?MjJRL1RpcmN4dzVRbkpocFQzelROa0tINUV3MEZIdmlaV3o4cXVUS3BVZCtP?=
 =?utf-8?B?eElnbUJiZGpxSVIya1lvbmdzZlphdFB0YUpiOW9mWW54SjBxLzlHL09Ma0h1?=
 =?utf-8?B?dzBwV1VSaWIwNlN1WEN2cTBRbkZib3BlVEhHRjZ3Y3R2TXkyNklZSnhGSmMy?=
 =?utf-8?B?U2YwWVUrMzJMVnBuaWxWT0lCTFJha1dwNzlpUWFQR0xiSFB4SmxURkxDSjFx?=
 =?utf-8?B?enlIWjQ0TGNCOUhjRVZlaytsN1g4OE9hNGNSRTFPSmVZZUVJM2EzN2ZEcTdL?=
 =?utf-8?B?dkFSU3dtVU1wUnlNVlJ6N3lYcGM4QTdSRUl0S1FITzRYeEUzSi9WYW9pbmUz?=
 =?utf-8?B?eDV6U2U5Vm1FSVlOclpxVUF5U2UzM0JYK3ZjNnFyMjBaUk56WTdudHk3NUNv?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PacpOAZ34hkHT9Ndj14a4nvDBNoOASfYMJfwMNU1mr2AAVblgJ6vYgxOxijOhOHbbcr7J8UdkLqdmwYl+B5EYKFgexgdcqfrQsIuO4lp+xI4f/pvKR1z4bnay1rklf07OHUXCPOmOR9KreVJwe7qRIA+yetPeLiXvOyWt+OqPScY40PeVyqEDBDZhdODinMurotvvUOcWmIPYVv8xGVa00Rouuk3g3/G/pAgAm7jz8lx6zh6LK/ijSvpjn5Qd5W0ok96SPDlH8nbiY+8HstKAmxrylOyS7evclF6uOSGMPZQ6t8rQqGJTH347XNrfsk8f871hwnHgoVgkKlAGFDV8NnUP4TWxhagiDdjx3Hnx7Ll5SFx2JRLtgSzqmAj+ZDkixErBruLF9Khjg3EiSnXudHtrmPv283PdISBkNX+8QXYOokRUejCP0lOkt+qgmt0ocFNgz1/WPdRFrDWB9OC41wH6Z9As/nP5KrV+5MYfY03ZovcIAlFB8fKDFHpmUkVlOEs+oiXhZaqSYvtov+kKsCBLyQePe8A+prjf0PJh6jqAvH9Fp0m7SzuPzarUhqlHZB+l1/t8Te+1fITd0R1PfhYSjZtDsmvSa1TBZJQMa4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbdaabab-257b-4c39-8ce7-08dcc79eb4c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 20:19:23.5486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PY+nVqgGprfqD2WfC8aeX98cxseab+sVnOvrhv/ePWPBhvznKRr79L0zCALi7Xj6h8FvC0NeH/+B3cQRUXHfOBuYVx2TTNWdole432BLJLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_08,2024-08-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408280147
X-Proofpoint-GUID: tzuMwDWDJkz1TQbHxc-cHD4-kdwnmYNQ
X-Proofpoint-ORIG-GUID: tzuMwDWDJkz1TQbHxc-cHD4-kdwnmYNQ

On 8/28/24 10:14 AM, Ard Biesheuvel wrote:
> On Wed, 28 Aug 2024 at 19:09, kernel test robot <lkp@intel.com> wrote:
>>
>> Hi Ross,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on tip/x86/core]
>> [also build test WARNING on char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master efi/next linus/master v6.11-rc5]
>> [cannot apply to herbert-crypto-2.6/master next-20240828]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://urldefense.com/v3/__https://git-scm.com/docs/git-format-patch*_base_tree_information__;Iw!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmIxuz-LAC$ ]
>>
>> url:    https://urldefense.com/v3/__https://github.com/intel-lab-lkp/linux/commits/Ross-Philipson/Documentation-x86-Secure-Launch-kernel-documentation/20240827-065225__;!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmI7Z6SQKy$
>> base:   tip/x86/core
>> patch link:    https://urldefense.com/v3/__https://lore.kernel.org/r/20240826223835.3928819-21-ross.philipson*40oracle.com__;JQ!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmIzWfs1XZ$
>> patch subject: [PATCH v10 20/20] x86/efi: EFI stub DRTM launch support for Secure Launch
>> config: i386-randconfig-062-20240828 (https://urldefense.com/v3/__https://download.01.org/0day-ci/archive/20240829/202408290030.FEbUhHbr-lkp@intel.com/config__;!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmIwkYG0TY$ )
> 
> 
> This is a i386 32-bit build, which makes no sense: this stuff should
> just declare 'depends on 64BIT'

Our config entry already has 'depends on X86_64' which in turn depends 
on 64BIT. I would think that would be enough. Do you think it needs an 
explicit 'depends on 64BIT' in our entry as well?

Thanks
Ross

> 
> 
>> compiler: clang version 18.1.5 (https://urldefense.com/v3/__https://github.com/llvm/llvm-project__;!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmI2SDLdTN$  617a15a9eac96088ae5e9134248d8236e34b91b1)
>> reproduce (this is a W=1 build): (https://urldefense.com/v3/__https://download.01.org/0day-ci/archive/20240829/202408290030.FEbUhHbr-lkp@intel.com/reproduce__;!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmI5MJDdIG$ )
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-kbuild-all/202408290030.FEbUhHbr-lkp@intel.com/__;!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmI-MitiqR$
>>
>> sparse warnings: (new ones prefixed by >>)
>>>> drivers/firmware/efi/libstub/x86-stub.c:945:41: sparse: sparse: non size-preserving pointer to integer cast
>>     drivers/firmware/efi/libstub/x86-stub.c:953:65: sparse: sparse: non size-preserving pointer to integer cast
>>>> drivers/firmware/efi/libstub/x86-stub.c:980:70: sparse: sparse: non size-preserving integer to pointer cast
>>     drivers/firmware/efi/libstub/x86-stub.c:1014:45: sparse: sparse: non size-preserving integer to pointer cast
>>
>> vim +945 drivers/firmware/efi/libstub/x86-stub.c
>>
>>     927
>>     928  static bool efi_secure_launch_update_boot_params(struct slr_table *slrt,
>>     929                                                   struct boot_params *boot_params)
>>     930  {
>>     931          struct slr_entry_intel_info *txt_info;
>>     932          struct slr_entry_policy *policy;
>>     933          struct txt_os_mle_data *os_mle;
>>     934          bool updated = false;
>>     935          int i;
>>     936
>>     937          txt_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_INTEL_INFO);
>>     938          if (!txt_info)
>>     939                  return false;
>>     940
>>     941          os_mle = txt_os_mle_data_start((void *)txt_info->txt_heap);
>>     942          if (!os_mle)
>>     943                  return false;
>>     944
>>   > 945          os_mle->boot_params_addr = (u64)boot_params;
>>     946
>>     947          policy = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_ENTRY_POLICY);
>>     948          if (!policy)
>>     949                  return false;
>>     950
>>     951          for (i = 0; i < policy->nr_entries; i++) {
>>     952                  if (policy->policy_entries[i].entity_type == SLR_ET_BOOT_PARAMS) {
>>     953                          policy->policy_entries[i].entity = (u64)boot_params;
>>     954                          updated = true;
>>     955                          break;
>>     956                  }
>>     957          }
>>     958
>>     959          /*
>>     960           * If this is a PE entry into EFI stub the mocked up boot params will
>>     961           * be missing some of the setup header data needed for the second stage
>>     962           * of the Secure Launch boot.
>>     963           */
>>     964          if (image) {
>>     965                  struct setup_header *hdr = (struct setup_header *)((u8 *)image->image_base +
>>     966                                              offsetof(struct boot_params, hdr));
>>     967                  u64 cmdline_ptr;
>>     968
>>     969                  boot_params->hdr.setup_sects = hdr->setup_sects;
>>     970                  boot_params->hdr.syssize = hdr->syssize;
>>     971                  boot_params->hdr.version = hdr->version;
>>     972                  boot_params->hdr.loadflags = hdr->loadflags;
>>     973                  boot_params->hdr.kernel_alignment = hdr->kernel_alignment;
>>     974                  boot_params->hdr.min_alignment = hdr->min_alignment;
>>     975                  boot_params->hdr.xloadflags = hdr->xloadflags;
>>     976                  boot_params->hdr.init_size = hdr->init_size;
>>     977                  boot_params->hdr.kernel_info_offset = hdr->kernel_info_offset;
>>     978                  efi_set_u64_form(boot_params->hdr.cmd_line_ptr, boot_params->ext_cmd_line_ptr,
>>     979                                   &cmdline_ptr);
>>   > 980                  boot_params->hdr.cmdline_size = strlen((const char *)cmdline_ptr);
>>     981          }
>>     982
>>     983          return updated;
>>     984  }
>>     985
>>
>> --
>> 0-DAY CI Kernel Test Service
>> https://urldefense.com/v3/__https://github.com/intel/lkp-tests/wiki__;!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmIy5kGTJf$
>>


