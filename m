Return-Path: <linux-efi+bounces-2929-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 984E1A571E1
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 20:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC5F7174B20
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 19:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983A824167B;
	Fri,  7 Mar 2025 19:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F9NSb52l";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ybfVYFqm"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A359B224242;
	Fri,  7 Mar 2025 19:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376028; cv=fail; b=OElFvLLogH9KDWLu6BiKPH7B7V1oHzRToJsORz97TV2sVL55iZZoKyltRQE6QeeO1fFFzqBXSoCt0AeFKfTauGVA3OtiackVhtacRRC+Zmjr5j5y3zJVgfiV89R0Q+XQU3ked6eLEZG4L13FTh9Dy4IPibnqN6Ohdnyg4+2LasE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376028; c=relaxed/simple;
	bh=MgGT5qUftWDOcI/6YHgiH0dcLajtJy4HwGAWbcdV7DM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LntIpor3SNfcfA6TWs58Iv+Id+BLHO1w6EFJhpLytI3ufE5v9dbcTFQh0/VB6Lbc0aZ/GRhYMhdKpw15R4WB32s5ngY4CdG3wpZ1WVP/So08TitRJQaz724jsLX6Z8p657nEt99nXEhCxXg4Mcz5kPVTzcHETedQ+RwtwPOubKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F9NSb52l; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ybfVYFqm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527ItgRx017840;
	Fri, 7 Mar 2025 19:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=WpweWHRNkZtglLUakhxV6wcSPTL2u0u9cY4kdyBGY6E=; b=
	F9NSb52lxPlHmLlqf2QqH75wOhL9J0u9gulorNAUZQrp6je8NbpAoD6QTM/KVR98
	Yp/YUIbuZVAh4YJvVDxI8nhsrl73AEaFnnCBoamcePs4zCXO7HUuRWs0YlMkVok+
	dLydqDuhaF9RH98pINPI+VHjBjfQRFW3u2GbWoyCxCYXTCLMh8dfIT6TLNCCEVxw
	7zaDfpBwCzgxBTHTS9Ea2o9W4/uPhBGTEftDEfjj5jNRlXMsNIVDBH3qjaH6o55T
	5Dy88vAJ8Ddf32DcB/ZCeUOQAmiZ4OE8j1fb4tO/XJV/RpL+aeviAyAGvNOmzPad
	sydyxfbXG/oGlRPI6xawTg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8wvrk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 19:33:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527IlsaR038899;
	Fri, 7 Mar 2025 19:33:12 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpm76jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 19:33:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcWo27ObjYY6u7gLx/8kMucy8x/crS/3iNcNsKkPnrCiirNHfISnEGRhYja6BU/ZZ7TLX4GZtUIkY0tjBdMuiSwyC37P5cgOQsW/g9+KmwnKjN+gvajbjbf++tcAXwPaizNB8MLSMSatr2EcZBAsTlhIZ497UIlrR6jD4bKq9z88Ij10cU/oIiB9AMzsDXo7Ss/nbq3fzGL7yIjaQxOtUy+D3zCeiPTIO3J6ENHitq+hBnu72txvAPuJcYUoHjT+MEau1xM3itEqnCp8RvLK5ZhnSPpL1oCn9SO9+A1FFdc34QHAHX+xEHt/yJsQ+aYRfXecXiqQc2NmAR1+zkZh/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpweWHRNkZtglLUakhxV6wcSPTL2u0u9cY4kdyBGY6E=;
 b=vd2UDDiAddfy1gk7wYT8NxtSjUAFMS7YihbT1R51Vqgf5H1VVhDDQnAUmTAtJbo3XELv6vCLcT5IZ1yp1tF8EOjMyiF8GV22Fg7QFtoy7UsyGAqBqq72+I1tGQeDMUX/M6a7W+9GCrIekcHT9U0mMY60Q28VGSK0qbA5jgPHM7314rkq2h9lclBEHjDl0gq7u2YFQDSfxBoQieIa8h3o2A+fzez61E2jRXi8sc855POIrOalDMbMs/Zed+j68qlLIlPdJw8//SqOpTPB3dBbz7WB38jmE6QeciT4/F7sK+mtgThBSfSR4V8GOlLS6K58Sh+8Xs3qhAvlQwYIqmEnaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpweWHRNkZtglLUakhxV6wcSPTL2u0u9cY4kdyBGY6E=;
 b=ybfVYFqmSiLZbXFqybypn0RIPM1nWwFTiH1LokWFXKGNGTq9iqB0jii/oUGVmjsJtNzZZMDbD2FkXfg0YcUeUyi8lXaF7pVePVsRiOuZWwwW6KIcYP7WIphF7qe8UHaz6sfTw6OK8xcrxbtoG9vn0TWzzkVDHjIbF8v1JxEATdI=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 DM4PR10MB6160.namprd10.prod.outlook.com (2603:10b6:8:bc::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Fri, 7 Mar 2025 19:33:10 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 19:33:10 +0000
Message-ID: <fbb6349f-4195-4d83-8d51-99bb91ea4fe0@oracle.com>
Date: Fri, 7 Mar 2025 11:33:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 08/19] x86/boot: Place TXT MLE header in the
 kernel_info section
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        luto@amacapital.net, nivedita@alum.mit.edu,
        herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net,
        ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
References: <20241219194216.152839-1-ross.philipson@oracle.com>
 <20241219194216.152839-9-ross.philipson@oracle.com>
 <Z8qXVLiab5L-XkgP@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <Z8qXVLiab5L-XkgP@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0102.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::43) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|DM4PR10MB6160:EE_
X-MS-Office365-Filtering-Correlation-Id: 39dceb9e-3318-4a0a-4605-08dd5daee4b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RVYzQWpxWHd4cXBmMXR4bGVNQW1haGxxL1JkQVBWa3gwZXNxNGZPZUs5RTBF?=
 =?utf-8?B?eGJ6b3puK3BYUzdTOFJtMzFnbTBVa1lMcjdqbkFxK1NaVGtqOW91SU1mZHU3?=
 =?utf-8?B?a3dvcHlQMXUvZHhEbWI4bGxXRmphOUN2aXI2VGU3ZlI0MFp1ZkpyVkpPVGNw?=
 =?utf-8?B?K1RVanB0WWRiS1hKellWdytUTjJXQXhJUG91L1pOQysvdXpvTHIxcW9Yblpx?=
 =?utf-8?B?SmcvcXN1aHg4bUQ5V0xsd3k5RjkrV2hrRmtiSWViSGoyQjZndlZiekhhWnMx?=
 =?utf-8?B?VjZHcUNwdU8rNFV5WTdHSm5iZmovdXVMQSs5WS9NK2FDTzZ5bTB4VWRmd0JS?=
 =?utf-8?B?OHZTR3dRVzdxRHFJVkYyVWJObFgybVBwM0VmOEZscDMzTVZISUV1ODljY0FE?=
 =?utf-8?B?NWlEMGJCckoxTHNEU29vRW9meXVQWDcybVZzcEJseDJScVA3ZFExbEZWNVU2?=
 =?utf-8?B?b0NFSXNxeGkxUHhGU3VZY2huVE1IRmZ1a1BZR09YTWxrUTRqU2tjemY5bjNn?=
 =?utf-8?B?anY1RG1OdEdqdzJ5R29hNGFwSXhYUEs0ZlpMRUtCZlJDSUVkVWU4VHluSjdB?=
 =?utf-8?B?eHJoOXRSbDA3ZDYzd3g1N0hJNDNhUzRtSlRaWFhtbnNZa21CdG53cklFT1Rt?=
 =?utf-8?B?eDB2enVldFNuYkYxeG95TnFpNHVoNzY2azZaNGo3ajBCVmRiVWdzWXRzbWZX?=
 =?utf-8?B?N0MzUE1wRnlHaWc5TGxtQ1lJN0VFRVlEOGNuOGd4STlPb2NxVXlCdVJCSUFC?=
 =?utf-8?B?eE9MMFp0WGx3RUhaM3d1MGtleDBnLzFJNm4rVU14bWNvRzdVQmlaSExQN3Q3?=
 =?utf-8?B?d0xVVVM2eUd5VXJVeklqeTBIb0pYcndWZVZrMkFSR2V4dEx1WVpGYUg1M2RW?=
 =?utf-8?B?SE0zQWo1UDB1RVE3QjRYMklFblFwcGd3aGp3NDRNRVNFQUExQk80UmsvNTJH?=
 =?utf-8?B?V3ZmRDA2aFFpN0FYMXpWTFhvYzVQLzdtZjVWZ29ERE1zMnUzazV0dm5JUUdn?=
 =?utf-8?B?bXlLaGdkWnFoMHhsS2FuakxFR3dKYkpTT1E3NUx3V3M2NklaaGswRjlGWUhh?=
 =?utf-8?B?MFdMMGhXa3podFVIaGhKMzFWVTZuWk9QRE4vZEIvMDBNVC9vb3pKaWhBdUNK?=
 =?utf-8?B?WjBqQ1MrL2k5WGJXU1J1VGtDWkhnZ1FHb1UxTjQ2S1J4M3VEQy9XUFhicFky?=
 =?utf-8?B?RnFpSVMvb0RSMGxPUjhQcWhVMk4zQ1NuVHBvZWhWWXUxY2cvM3JYMC9qT1dl?=
 =?utf-8?B?c0ZnaEhlaE9PTllOVjdtN29OU3JVazZxL3dDTUpySnNxVm9BS1J1ZHBVV0g5?=
 =?utf-8?B?bmlHNitvWm05T1hIaHZESUNnWlNKbGRHa1paZ2tvOGJndUE0LzNvenpkWmhw?=
 =?utf-8?B?WDZ5aU5JZmIxNXJlWlhwc3ZrN3pEenJUMktkR0Z4T2ZvbW1kNHYzMUdySnVO?=
 =?utf-8?B?U3ZqNkFWQkczQUNZQ0UvaUx3NUROZFNLc0J4dTArVW5raGx4UHluT1diMXNI?=
 =?utf-8?B?QWR0Z1hSU1U0ekV2VnREWlhXYW9abDl3VEE1QTVpeUpYVisyOG1hVDJTaVp2?=
 =?utf-8?B?M2Q2VC9INFhnK3lQeU5LY0d2UTRkc0lnODBIQW8rNFdyNVZNZ1NwOUhPVVhX?=
 =?utf-8?B?T1RCelJGTDJtcWU0TFB2cHZYZHA0UEhSU3ljMDNpOEt5OEk4M0lWTEZmS1JT?=
 =?utf-8?B?Z3BlaDdJcTN5S3Q1SHpVVC9weVZtY2ZyMW1lakNSZVJEMzNMUWRaSFdWRFRI?=
 =?utf-8?B?c3YvbUNPMXcwSjBmWTdQelNHcGp6emgwdXNBL2M1dXFyWkE2ZGlJT3A1aGVE?=
 =?utf-8?B?OGZNVFMrZFRsNEJGKzJZKzZiRllzTzc2OXVpL0hxRHdMZFBwdWpVOHN5MnlH?=
 =?utf-8?Q?opobzV5B4/wQd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R01BKzZMOS9nWmFEWkRsOHE1dStxMEdpVDM4bHJlWVBOV295R2h5N1lHRHc1?=
 =?utf-8?B?L1pNeWkyaUJnTlljMUFBU3l0K0I2YVk5ekRRKzRRa0pTWUsyZUNvTTdjSHlD?=
 =?utf-8?B?WHlJZWV4Y2ZtT0I4SjFRK0dURXE4RkZWS2FPdk1PeU02NlZobUFScjZTNThJ?=
 =?utf-8?B?c0oyUzZjUEVsMVYrY2laZE1Xek1DK0VLYzliQlhRMW5pOXdkYWthdnozcVk5?=
 =?utf-8?B?a0llS3lxRGhGVkNWeCtKWE1CNkR0T0VpbzNLcVhDeTFwb1dTalQzbnQ5SU1O?=
 =?utf-8?B?NjNLZTJwdTIvWitSSHdxcFBUOXYvTTNFVGFiQ2llZ1dxa1pxaWkvSDFkV1da?=
 =?utf-8?B?Y1BSWlpjdDAzS2tBK0F1TXRva25SZUlnVlM5WU05Yk1ZNGIyT3hsWm5Lek1U?=
 =?utf-8?B?WU9SR216eTR0dHNRTXcyMWowRzUyNENJZUpoMnJyMUJ2bS9hYWRNby9CQXFq?=
 =?utf-8?B?NTJCK2trY2E2cjJhWjZjVENyNW54UlZydXhHeW5RdXJmNHN5cjVHV1AvZnZH?=
 =?utf-8?B?YWxhZVQxNnZVWDZmYUNrOFJ3b2t1VzJQOGpUbmFRSERXN0JXK1pUd2tHNVdR?=
 =?utf-8?B?SlJXUE9LOTB3NFVSdzZNUXpYeXNuTXhDMXpNenVrckl3cnNiek8xN21sNmZX?=
 =?utf-8?B?ZThmZDJCcGRJRGpyU05zTk41dWgxZTJWQzNqTXdjeUtmNE9tYnpvL1gvOEUr?=
 =?utf-8?B?QkNhbk1MY1RxQnZseGwvRkozSnpWUEovV2RNK0tTcGZleW0rcnBXR2dNTUsv?=
 =?utf-8?B?eWQ2MXNrQmVpUGhrVklSbUY1c2lWZ1ZQVHNTZVJUY1lScFhDQ01hcnpCZ2wy?=
 =?utf-8?B?RzZEUVZiamxEbmw3S01xNHoyR0c4L2xFUHA1NnZQTkJuTzRDZGFUT0tTWmhv?=
 =?utf-8?B?dXc5eDlKYy9rd1duMkE4NTJ6Z2srejh3L1Z2MXlKV2hrY0xLRTJ1K251dWFx?=
 =?utf-8?B?eER4SHVOZ2hVL2ZXV25va2tHU0RneHdCbit3aW01KzIvbXlCS1gxdEZQY2dG?=
 =?utf-8?B?ZUd4OWY0T2V5NWRjN0FOUU51Nk01bTZzOE84OE1rblZhcDVFNm0wc21lVzdK?=
 =?utf-8?B?RXlzZW1qUzJNVFc0eTlBbDRKZm10V2RKRzVGZk4wdnFPbFlqZUNwck9oZjB6?=
 =?utf-8?B?YUxUNDBTWTBwaEhIQmw1K0JjcXQxTE9OR0lSa2x6NFZCYi9EWHFvOElZaEI0?=
 =?utf-8?B?amV1YytpYmIwdHFDMVpQdjU2ZGtlTkFMaHRTRm5MU0dJSHBCekVRanR4UnNX?=
 =?utf-8?B?bWRjbmZwbXo2T3NYdXE0dUF5L0hwaFFPV2Zxb1p0Z3R1Y0RKZEx5MTJSRUow?=
 =?utf-8?B?OTF3Vk9VNDB4eitpQVlrcG5tNGhiazRTQ0Q4ZHI3UVRhelhIdXlnUnlraHAx?=
 =?utf-8?B?ZkVPaWV2ZkFHQ2xLeWhQcHlwcEFMc3VHTjkvWUY3MmNsaWwvbkd2WSs3bkdq?=
 =?utf-8?B?cS95QkVxRm9EUDY5MGI0TFgySGNjTUhnR1g0UzNFS29nQUUrVldDZktFZDFl?=
 =?utf-8?B?cU5FOWpoM285aERTbC9ZcDR2VTJiNUc0MnM2UDNvYng2UTdxd1dpTmJNY09h?=
 =?utf-8?B?QW5lUjlNZmlSTEVlTmpGUk81MnRpckFzQXU5dERxS3JWK0MwUGs5bXlzL2VO?=
 =?utf-8?B?MWRrTndlNXp0ZTQ2VVZSY2xRZlU2Sk5TakttQ3JaZGtnRTc4TUVjVkJjeWIx?=
 =?utf-8?B?MkxadjhXWlVudTg5U056bngxaW5EaUl2RWl6U0gzdG1yRGJaczRNU0JZOUpN?=
 =?utf-8?B?OTE5V0FQZHkwT2I5Tk56dGtmV1VlVmZubGUvc3hkTnYwRWRiaXJQVHZaL0pM?=
 =?utf-8?B?dGU3WngrUW52TUl4UnJrd2h5U3RGdXJvNWNyTTJNOGtDZHF1eU5WQXlveVBC?=
 =?utf-8?B?TStnVFBnZFluQ0tiY0FxdmxsUHoxU044TnNuWW5wQk9sV2p0Mml4ZzluYWwv?=
 =?utf-8?B?ZG1WbjI4dHBuYVBPRnFzQ1dqOWtVdkRhMFR6c0pXRTNENkF1bWxNZHBod1Bi?=
 =?utf-8?B?LzlNbFVGcFMrOStNd0tXVlBqekhkRFhnZGo2VUc3VVp6YmJmazU3OTBOWEhN?=
 =?utf-8?B?SUlSWDczQ2xUYWZGMWhvQWZLc2Yyc2VYSjFoeDVjdmFPWUFnd2JKM29wMit4?=
 =?utf-8?B?bmg0THgwdVBiMGlQeTNTM1g0ZGFsVlpiWWl4T25rZHphSk1UZlhDQURsdnBu?=
 =?utf-8?B?Tnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Sdbakk5NuN8ZopG87lTV1KXCqJcbgTyf5Pv6lI2CN8H7PpbbJCNP458rjQ2newvJw5ZW+03dr4iHyp3GMMMgJlkGTg+sBuKo+TZgkGrbe/9akTmYr62VdXwNltrLXbd4VK6iq9ECS/8btEnJanbzbgDVt5f99n4u3Yn4FmJhHy8cOTGCcplwMFGUueEyZBXvmf4gv6OXDMSjymDlPXUhBBvCvevnVuJmfec555BwQp0AuH8LRUvo1Nit78LKGTLGRRROyvBWA7UVP6LFrVuaEjrkmMcOQXemtyWDisHy22cvV8vSjAZYOZVUSt+EhGILsyCIBwa9mopqpEu7X1fFSG9AzveMwiUz7Rz30q+6mzFkuxBFRsG/alxHFJ4bs35PKlQqnnWD+TtWv7sqW32WTvHvgmadwVuNbpOby9+jJzECHov7O7NEKfpvvIYtfgxJVK8Jro7+adjhuUFMrIkzRUh+qdiy9CKE/E8QW94C6H9I6rIAq0veouPYBLJnP9eSZQtbjiqhO6NlILTOOH6K//6qep6yhKorHqs4QvMjMQe3cl2qmtLMdur5rYg2sOuK+V4EmBzi8F4+cgrJZF7DnjFYpcu+ker/4mt4X5n5AoU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39dceb9e-3318-4a0a-4605-08dd5daee4b7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 19:33:10.1220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ed0f6kTt/HeLCQ2KWSvOj8MzY1Ok+V/4ZNh2lIErqlwkwGIqgsQpr43oItFfEmWW6aG43RLObxREXs+6eoKbqbW+F6ZkneJ/zOMxFZ/YMqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6160
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_06,2025-03-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070146
X-Proofpoint-ORIG-GUID: -iIxlmYec6JD5jI3khsniq3bUwfAoKm3
X-Proofpoint-GUID: -iIxlmYec6JD5jI3khsniq3bUwfAoKm3

On 3/6/25 10:51 PM, Jarkko Sakkinen wrote:
> On Thu, Dec 19, 2024 at 11:42:05AM -0800, Ross Philipson wrote:
>> The MLE (measured launch environment) header must be locatable by the
>> boot loader and TXT must be setup to do a launch with this header's
> 
> (cutting the hairs) nit: /TXT/Intel TXT/
> 
>> location. While the offset to the kernel_info structure does not need
>> to be at a fixed offset, the offsets in the header must be relative
>> offsets from the start of the setup kernel. The support in the linker
>> file achieves this.
> 
> This is too obfuscated and also sort of misses the action taken by
> the patch.
> 
> I presume the goal here is to add relative offset to the MLE header?
> Please state that explicitly.
> 
> Like for any possible kernel patch:
> 
> 1. Come out clean 110% transparent.
> 2. Full exposure what you're doing.
> 
> ;-)
> 
> That's the fastest possible path to actual results.
> 
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
>> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
>> ---
>>   arch/x86/boot/compressed/kernel_info.S | 50 +++++++++++++++++++++++---
>>   arch/x86/boot/compressed/vmlinux.lds.S |  7 ++++
>>   2 files changed, 53 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
>> index f818ee8fba38..a0604a0d1756 100644
>> --- a/arch/x86/boot/compressed/kernel_info.S
>> +++ b/arch/x86/boot/compressed/kernel_info.S
>> @@ -1,12 +1,20 @@
>>   /* SPDX-License-Identifier: GPL-2.0 */
>>   
>> +#include <linux/linkage.h>
>>   #include <asm/bootparam.h>
>>   
>> -	.section ".rodata.kernel_info", "a"
>> +/*
>> + * The kernel_info structure is not placed at a fixed offest in the
>> + * kernel image. So this macro and the support in the linker file
>> + * allow the relative offsets for the MLE header within the kernel
>> + * image to be configured at build time.
>> + */
>> +#define roffset(X) ((X) - kernel_info)
>>   
>> -	.global kernel_info
>> +	.section ".rodata.kernel_info", "a"
>>   
>> -kernel_info:
>> +	.balign	16
>> +SYM_DATA_START(kernel_info)
>>   	/* Header, Linux top (structure). */
>>   	.ascii	"LToP"
>>   	/* Size. */
>> @@ -17,6 +25,40 @@ kernel_info:
>>   	/* Maximal allowed type for setup_data and setup_indirect structs. */
>>   	.long	SETUP_TYPE_MAX
>>   
>> +	/* Offset to the MLE header structure */
>> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
>> +	.long	roffset(mle_header_offset)
>> +#else
>> +	.long	0
>> +#endif
>> +
>>   kernel_info_var_len_data:
>>   	/* Empty for time being... */
>> -kernel_info_end:
>> +SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
>> +
>> +#if IS_ENABLED(CONFIG_SECURE_LAUNCH)
>> +	/*
>> +	 * The MLE Header per the TXT Specification, section 2.1
>> +	 * MLE capabilities, see table 4. Capabilities set:
>> +	 * bit 0: Support for GETSEC[WAKEUP] for RLP wakeup
>> +	 * bit 1: Support for RLP wakeup using MONITOR address
>> +	 * bit 2: The ECX register will contain the pointer to the MLE page table
>> +	 * bit 5: TPM 1.2 family: Details/authorities PCR usage support
>> +	 * bit 9: Supported format of TPM 2.0 event log - TCG compliant
>> +	 */
>> +SYM_DATA_START(mle_header)
>> +	.long	0x9082ac5a  /* UUID0 */
>> +	.long	0x74a7476f  /* UUID1 */
>> +	.long	0xa2555c0f  /* UUID2 */
>> +	.long	0x42b651cb  /* UUID3 */
>> +	.long	0x00000034  /* MLE header size */
>> +	.long	0x00020002  /* MLE version 2.2 */
>> +	.long	roffset(sl_stub_entry_offset) /* Linear entry point of MLE (virt. address) */
>> +	.long	0x00000000  /* First valid page of MLE */
>> +	.long	0x00000000  /* Offset within binary of first byte of MLE */
>> +	.long	roffset(_edata_offset) /* Offset within binary of last byte + 1 of MLE */
>> +	.long	0x00000227  /* Bit vector of MLE-supported capabilities */
>> +	.long	0x00000000  /* Starting linear address of command line (unused) */
>> +	.long	0x00000000  /* Ending linear address of command line (unused) */
> 
> Nit: I'd consider aligning these to few tab offsets after even tho it
> might cause checkpatch complain (which is fine when there are legitimite
> reasons to do so).
> 
> Would be easier to read.
> 
>> +SYM_DATA_END(mle_header)
>> +#endif
>> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
>> index 083ec6d7722a..f82184801462 100644
>> --- a/arch/x86/boot/compressed/vmlinux.lds.S
>> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
>> @@ -118,3 +118,10 @@ SECTIONS
>>   	}
>>   	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
>>   }
>> +
>> +#ifdef CONFIG_SECURE_LAUNCH
>> +PROVIDE(kernel_info_offset      = ABSOLUTE(kernel_info - startup_32));
>> +PROVIDE(mle_header_offset       = kernel_info_offset + ABSOLUTE(mle_header - startup_32));
>> +PROVIDE(sl_stub_entry_offset    = kernel_info_offset + ABSOLUTE(sl_stub_entry - startup_32));
>> +PROVIDE(_edata_offset           = kernel_info_offset + ABSOLUTE(_edata - startup_32));
> 
> I'd enumerate these one by one in the commit message. I.e. what is added
> explicitly.

Everything you say here makes sense, we can incorporate these changes.

Thanks
Ross

> 
>> +#endif
>> -- 
>> 2.39.3
>>
> 
> BR, Jarkko


