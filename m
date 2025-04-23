Return-Path: <linux-efi+bounces-3438-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C35E7A997D4
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 20:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 039964A31CD
	for <lists+linux-efi@lfdr.de>; Wed, 23 Apr 2025 18:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D64D28E61A;
	Wed, 23 Apr 2025 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="llkeTjBX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uJQMv7ve"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E73128CF6D;
	Wed, 23 Apr 2025 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745432711; cv=fail; b=PNNHsf7AtEtqUR80+TTjsn0srRyNiDSK1phlRLzc+oetghr8qTAXNuLUz4aUpksydW4YUleLrjI9vTlq8T7tLaeGM4Y2Z4bNDVG2mVXtaVYIDQ/WN1mv70z0OVuwF8p8TEoSaDJeZUkV2DljJdX8YIAxJEN4MU9RvBZikOHx9tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745432711; c=relaxed/simple;
	bh=uteghZfpxPTxyE4YaEhW20l8d+LGkz/Uc2v/90centE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uN7RXVKfZkmF9fjgbMVTSzMVA9TPGf5ciF4WTNht9QTpFvqDifMn2z2ib8miI2nzf+YnTUeLxrsFAWyn7S0EuC+kzaFCOQCB/pmwE19SyHqaJ/TyJbFpTxNM9krWvfLOUu2StPkX55U/o2OxgSdsvJi9Y0wdj4FVcDyO7KNipl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=llkeTjBX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uJQMv7ve; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53NGtl79022361;
	Wed, 23 Apr 2025 18:24:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BrtD1iwL6GqRMPnW0YLw5hcaPdsl3ATaew4LnmXUeyI=; b=
	llkeTjBX5aBVolWweHsV+jqWgIcx2t8RbYcnlqRI3NxxN2rZ41JnLAipF9NsIga2
	PRoYWjrzOA1xJhePjqFzHG3iQeipcvycnCJ1oQmWF+G8E37uA3aIg9B8eiqOOHSa
	lKh+mub/ReCbfQ3vnvrg9cBS44LFp6X9wl5yib1Sel3k3EZ7hQwUikL1QM77tAzq
	uobEJwaUsZSRvhZiFoYxBQLJewz0jFCKYwDsKQGxtIYQigdIO9LIPFF3d6nyf3LE
	dH5MErrVwZo5T2KNv9NGXpVVQwJ0B9Iy8bmnu8HkVwx2AjOH92N23oY9ooCTlc2E
	Xf3YaTKB6+1JxwhzmcLh/Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jhe1xbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 18:24:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53NHr4k8039241;
	Wed, 23 Apr 2025 18:24:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jkg0sns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 18:24:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUy3fNbFHKV6Vx8tL5XRmc90RmWKGHJlQ7u+Q7jChEn1tQrpfv8DZP5p9wSR/Kqx/tm5QMIErFgN8FuUg31xrjNVoLoWH4U4WyRvRx64gXtFB1+XbW+5gLX7MucM3VjaFe3przPAD/6fVqxiRYBIIXNHyeaKrq0Zm/zAb4ORUSb/B79J2Yr+Zk+GYlsgbastnt81plhZWvmkX47ztlABgSmSw7XNQXXryol0QYriJCuXbMrhMDVPXmQ7fjMqRQNYokqYQUXFjCK1gCfFGvSXLHoTniuZ6tTYzndwq8aNDYz90SHVB9qWkSQdLrSkerDExoZCjFEXyLqF6BnIwZnlEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrtD1iwL6GqRMPnW0YLw5hcaPdsl3ATaew4LnmXUeyI=;
 b=VDi2GrbElAu5NtFAS1YR/CLvOjXTpjYqiYIIWx7KA0o9oXOQHqelPiXf+aE0DYJAY19glSws7Cypdr7x0NZung/soBDCnC5Ys7czt+HsL3XqpJoi2Mpjm2mmYKaMWs755FmHslN9AOi4rMhTmKJ5zZ5AqBxorfu1njurDEhsgv8U6qPme/dM1KFEcY/6ds6Gq3hKrbp875/+Vjy7lhfkzfp4WyBIzJb85Nm8fwb3owg1bWZLjXBtlaiLrwzUTX0L/SYvDibqbCqkxSrB4Pq0jOpV56ah7XljfsTBdOJNZRlG2staXyZQNu2YdJXZY7uwLTGOkFBNu4kz45hCZI7PGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrtD1iwL6GqRMPnW0YLw5hcaPdsl3ATaew4LnmXUeyI=;
 b=uJQMv7ve+1tYJFpgnU6nJZnHd7Zr6HdGbUTsbYZCCtYlbs2LHUqDEuTgNGf6os6paNFEj3XpiC1u+w1YFKVj4KNCiR9Mzh7F0Mzs335qFlK2grSBgUKLHkug2ondRK3M//IEY+0NMAnu/oLLdNByAig+xMCjYNhs8YZu3mjziXY=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DM4PR10MB6813.namprd10.prod.outlook.com (2603:10b6:8:10b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 18:24:20 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 18:24:20 +0000
Message-ID: <78f10b6a-cfee-4cd0-b449-ccda84913b48@oracle.com>
Date: Wed, 23 Apr 2025 23:53:01 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 03/19] x86: Secure Launch Resource Table header file
To: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        iommu@lists.linux.dev
Cc: dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
        nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
        dwmw2@infradead.org, baolu.lu@linux.intel.com,
        kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com,
        trenchboot-devel@googlegroups.com
References: <20250421162712.77452-1-ross.philipson@oracle.com>
 <20250421162712.77452-4-ross.philipson@oracle.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250421162712.77452-4-ross.philipson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:404:42::21) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DM4PR10MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d3cf70d-0a2b-4c88-4af6-08dd82941041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEpjb3o4L1g3NjBmOU5adU02emR6Q2ltVHNoeU5kajgzbm5ZVzBNS3Fja3FW?=
 =?utf-8?B?UUVqaWthMVFsZDhtakJ3WFZNZ0NpQlJ1NlRtd2dqYm5UZ0NLeXFvclpQQ2J6?=
 =?utf-8?B?d2JSOVQ0M0xqUDBJUWpsSTM3c0VIc2tSZ05ycEtlQ1BEdXVUdG9FQ1dxODdK?=
 =?utf-8?B?UjgxcTN6d2NDSUM2cEZRSGxLQWtCMzN5VlBoUDdSY3FUTWhlMHJiOVlvN2JS?=
 =?utf-8?B?aVd3U1l6ZXV5SnFkTXV2TWJIcW9Bb01sNHJTQUg4ZFF2UkFtbG53VzExQ0xm?=
 =?utf-8?B?RlpDc2hzWGVoUWNNa2QvVXRRYkxDODROc005eGg0SVVhQkl3SGRIVXNIOCtF?=
 =?utf-8?B?bVNSNURQREo1MFFmN09oMGFEb1J2OFA4RmFaUjI2bzRQUnUzWVJReFVEQjd5?=
 =?utf-8?B?Q1dFdUhBb2hpeUk0M2lxL0EyTS85WlFoeG54MFhoSE5LY0VrS3AxK09BYXp1?=
 =?utf-8?B?c25jc3hybkNkT2lEUVU4eWFjMlpNTEVhbzBUZjNJQ0VNeU5TMWZOazNUWEtX?=
 =?utf-8?B?LzdwWW41ZUE5TFV1VGVVKzJBd3BXM25wbkJxa2xrdkM0QVVaRFFOM3pQZExF?=
 =?utf-8?B?TDNNbDdhdkJ2aVVqaE95ZzhnTGFvMm03dko4VnJ6cTI1TE9NbjVPZlg5V1ZB?=
 =?utf-8?B?b1BtZ2RIVHN0U1ZaYTRrY2FYejVIYUZXRE5QZjI3eVBOWXdMbjhVZ0JnQ1FM?=
 =?utf-8?B?dURXbldwTzBCZ0RkTmpyRG5MSFhyb0x4M2haeTBSZHM3Y1dqZS9MWWhrMW1n?=
 =?utf-8?B?RkxtTGNDTjlLTkRxaFlBQTBFWkNueVJlV0N1a2k4L1RMUVR0VUpiQkNRVWNI?=
 =?utf-8?B?UXY5SjBwZ3BCM2MyT1dzTkNZR0JKelpIeDM1YWovTCsvN2daMkRnSUl0aS9I?=
 =?utf-8?B?WUJpTk4rQllpck1HcW5MSlpOZjdtYlkzSTd6Z2NwSkVBR2xkTG5HWXVYNkk2?=
 =?utf-8?B?bzh4ODk5Skd2d1lNQ1gvVFNWNDEvT1pOQ0FkU3BlY21zcTFjRkc5OUdQVk9z?=
 =?utf-8?B?VnZ5Wml6a0hmUXkveCtNbkZtR1d2WSt1Qm12RlhGVThiQjFicFprZGpwODB3?=
 =?utf-8?B?VkxCNG13T2NIaUV3czNHNkFwVmxXV3Q3RVU3RFhwS0V4TDZtQXRlN1kzUUtH?=
 =?utf-8?B?NXVUb001UkFWdlpURTZzQXY4L25rRmVjRlh2SUxXbjZJSDZqWm9ZVXlYWDdm?=
 =?utf-8?B?dmZKdXJXQ2xpZlRoQjVYSTZUNDJTZFUzY1dGZFpheVF3WDhpZkVNOUY3RlZG?=
 =?utf-8?B?OS9uZjJqUzZlLzJ1aHVxU0xOd0gzZUdXeU1Mdi9TUVIxTk85TDBCZENmS2N2?=
 =?utf-8?B?eHUwWGNUVFR4ZXcrbnp1KzdjNGpGUUE0d0xBMGxxWk4wZU1zaTBZZnBHSDgv?=
 =?utf-8?B?Tk4rS0NjYnd0NElFSVFOMUpqbDAzNlQ3MmsvMUVFZmFVUDc3RHlPaThYWGFy?=
 =?utf-8?B?eExoUDVaZ0ZjWEtJWGRIRVNlWngzTDJETVhBd3Q3SElNTjlnOWpzdVVZZ1h5?=
 =?utf-8?B?TC9kd0JWRXhPYWd1WkZTaXQyMnhSWTJOREZnNFh5WWxJL0lWbUJld3hrTXZO?=
 =?utf-8?B?eFZaQlJUNVMwUFBZY2pyYUJHZHE0K2U4MmNaYk4vMmdSQzJjVUpjSndySHk0?=
 =?utf-8?B?bXhyYkZnWFJQQTByclhwZ2FtdXFNVG1SMSs0bzRiak1jQWVHZm50cllkaGFp?=
 =?utf-8?B?MU13RWRoOVNTT2owNG5ReEhlZXltaWNSd3J5VzM0VkZkTnFkS1hRb1RkditN?=
 =?utf-8?B?aXZTUS9Pa2xNT0ExanZmVkxaZFNlUlQ5dEpSYkxWTTFNVDFYK0RscTg2Vlc0?=
 =?utf-8?B?THlhTitDeDg5WWN3UHZZelI2Y2c5R2xEYTVBQnNEaHhveXBBNzZKR21sR3p1?=
 =?utf-8?B?eTE5UVdEQm8vMUpPb2Q4VzhPZVJKQlMrek9STjlHWGw4M2M4a3pBWHliOEFw?=
 =?utf-8?Q?SPojRQUeIlk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vy9weXBHQ0NLUEV3Y2U0dFNSRzN4czBvKzV6cVhlRGQ1N09CTUN1VU9rdnMx?=
 =?utf-8?B?RmgyYjRSc3ZWQnJnZGxCeXJieHNRbWgwMG42V2k3d0NZL1lvV2lUMThFZ0JN?=
 =?utf-8?B?N1h4bWN3OEhnWU13QnhKOFhxcitVWHlrU0E1ejBHSXNRSzZJSVpxZVhiT244?=
 =?utf-8?B?dmtLc0YwdGhqcjAxeDdnMWY0ZVRJck1aaGsvWksySFZyc21zVG5pbXRBNkJh?=
 =?utf-8?B?aWF6a0hEd0xaTlg0OWp3NnU1Ly9CSnJnZXlGNzlpWGY2OEw4K2VjRno2OVJL?=
 =?utf-8?B?bldFS29iVzJlWGgzQ2JnbW9jSVlPc2YzVTU0azRkc0ZmenhJVDRVMFJ3Z2ZR?=
 =?utf-8?B?Mm5pd1ZSZHpWZzZnOExSY3ZYd0VLRG1nQVgrMVk5ZnIzdDJ2eTlOcFFnRjdy?=
 =?utf-8?B?RlYwNmZyTnk3RkVKcVBFMklwMGRKRE5UWGo3VXRuN2ZYbE04Ylc0cjZ6cDNv?=
 =?utf-8?B?TmdISDU5azltbXRGeHZjZkNnMDFGVTVGOHJDdWVVZG8wVUU5amFwTWRxeW00?=
 =?utf-8?B?dEdRNmRzVGowNHhENXpkR3J4cUsrQmFRdFFXc0JGbzY1QVpoNUhKWW03UzNv?=
 =?utf-8?B?OGp1TXF1RllIZk1OclRqOEZjR1NmTDBZSWVFakZCVGNtQ3NKUzFkbTlPaUQ5?=
 =?utf-8?B?SkpONDhRaXc1aEV4dFpjTjIxTnFvcXVhaEU2MWVvK3MyVHhkL1FqT3ZFclZB?=
 =?utf-8?B?T3d2R1AxZ3k5S3pGRzk0NlBubHg5VGNzUU5JdFF5QmdvcnFIbkMyZHlnMHdh?=
 =?utf-8?B?ODBkM2RNZnBLNVdJM1oyNjA0dmZYQlF1eU9wSG1vWWh3WU4yNXlVZ0J1ZWRs?=
 =?utf-8?B?eUhVeUxPNmY4VmgzeW5ubHNWbWNKV1cwQ0ovcW5VcWdDMytTQ3BxWi9WdzJI?=
 =?utf-8?B?dmpRVVpzYUtCb2ZUb1N6RXZtRWdwRWRRMWEwTFRMVjE0WWhOUkh6ck9DbEZJ?=
 =?utf-8?B?Zm9vOWYwWUxBQi9ibFBmK2d2OTZzRlRoVkFHRGhjQ1h5b2RkeXNka2V4UlVB?=
 =?utf-8?B?VUJSUDVUdlBvcFV4Si9BZU8yMWNZVjlPUkZZUm9LdzJRVzJ3OXgzUnZUcXk5?=
 =?utf-8?B?OFpQckJEcFVlUlRyTXhVa0syZE1QMGtQRkJMTjJFQ0FZV2U3RmhQNnhRRXIz?=
 =?utf-8?B?OVBiTEd3N3E3OVJuQ0tua2U2Sk9FTk5rMk5XdWFZMnV6Wlh0TWNQa0VzNWpz?=
 =?utf-8?B?bVlQRlpjd2NlT2drNkFiZHBvRVdTM0JmTGtMSFpHV1JTSldEaDF4bkJ6d1Ev?=
 =?utf-8?B?Qzc1S21kV2FyWlMyRURaak16RkREUUdISm1uT0JHaFhyS1NPQVV3RzU1aC9a?=
 =?utf-8?B?MWtOOGorTVM0OUJTU3ZUbkdYRkJPQmJuQ2ZaSGtWSjRCVkQwZjRVdzNsRlA3?=
 =?utf-8?B?QnA1T0l1eThRQU40b3ZwRkFYU1JocUM5d3V1bjA0TmQ0a20xMk92UVR3ejA5?=
 =?utf-8?B?QjhNMkpUcDIvcGhwNVgxcUsxUGs2c2lJUzdUbXdYT2xwYzBpWGZWQ0NQSGpS?=
 =?utf-8?B?TEZ2cjFLOGMxWk1nRzQ5Sy9CUTVURkpTWlRwQURNQnNPTnFCY2ZoM3RqUnkw?=
 =?utf-8?B?VWpkMExCdUU2ZFpHaDdmM3RZUmNHTXZVYVdPMStBZkpqcXBMWDlacUtQK3Z1?=
 =?utf-8?B?eTdtVkFneTY2UGpDV3ZLU1I4Uk8vN3lIeHpvSUkxV0tKTlQ2bWxuaWJuOHNG?=
 =?utf-8?B?SGw1SlUvZHhrdnlTM1B0MnBHODFXTjk5Q0dIam5DY3N5UUJrbFFMRDVQank1?=
 =?utf-8?B?Nmc5SGxZU3JaeEdUMnNJWkFGYlBCUmkyc2N6TjNZbWVKb1IvK1VQSlpnRzh3?=
 =?utf-8?B?RkNZUVFLRUxpVVhYNmVoTCtMQ20rZ0VYRTBrMXRCSTJZeldPbitLbm5sQTZm?=
 =?utf-8?B?TG90NEppamxUTkYra3hEZzROblNkOWdHQ3hJLzhJd0VHWG90YlVjY3VONGw3?=
 =?utf-8?B?Y3FPbXVKNTFZMWFJOEx0RUpwbmxranBoWmE3L09ZSEpDcUVpT0FHNkxBd1Zl?=
 =?utf-8?B?TFowWmhtMWpLaFh6NWcvQVdTUFpnMForRy9kSE1HWVNXaWE4Vy9HekVYOThG?=
 =?utf-8?B?Uzd2UkVINE12ckJLbkhwZUtobHRzS1FtZ3ZodWczNWZJYUtmU1ltL09TTFBF?=
 =?utf-8?B?WGoydktWa1ZWbzhIZmtSelgvYk5IWUgxdXhPT29FWFptZnVmTVd2QWM5UThm?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LFYyVukmkgvJ4Xi26RAixfEiWz3SM2K8dXz6DAWy9scU7oY10deyFSd4H1+VvwEMIYNZe6u0SLDTe3hxPeCNu3enuaQMNaaDHgnh8dqstffTgw/FFtjWIATDglORDYVaK/Ju+XE8o0qGek/DWi7TGc6K/Im7Tpv5CE7xJrTU96ik6/bN0Dl7Vnn4RSOwpp+V3wzJ05lIchejTfilqArWVCJJjx6ko8Me4xzb7X918PRMbFmG93lL1EXYhxMmK1ONfiR6WrUFB8RMfCC4I4wI1VOcBdthDqbJijNpFnArLkgDDQlxlfwzyKlFJ/sLyy1pvK7I1OYxzfpT2QALh0zEXj+emZ1m8HM2Q0cYoOP0XifvjFsbMPEM2QqWtMMxgL4YdSh5bNlpm2umvixtvfy619ycSBwPjpqcs8CM2qpEmi3+5jg3XCFBo3XpSIqWTqEdix713zZF3ypQZvrAPQnv3CD/mmnQNmOCsWJ6HsDJ/5AZJg274P9IefyBcdvPCAUb5XhAT10YQiPsF2mdWIL68dzE+3fzootzNfkEpJkVS5VcWIkeT6pQ07RY0zOnzEKbb8EAfsMsQ5rJis/VMy4UXi8DPef0k/g97bMlf+nd0ko=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d3cf70d-0a2b-4c88-4af6-08dd82941041
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 18:24:19.9483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GcFuxGgWVeofb4skqL/ROuswy/wHk51BoNhQZjB64nhe9cNc5JuIifq+5hiwgaK0eKSbZ3/RIqyjRinWxGe5M57EZIZ+f82qlIky2BaIIWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6813
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.80.40
 definitions=2025-04-23_10,2025-04-22_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504230129
X-Proofpoint-GUID: TeggAVn3fG9GYuOY-tnl2EvYm3UmM7B6
X-Proofpoint-ORIG-GUID: TeggAVn3fG9GYuOY-tnl2EvYm3UmM7B6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDEyOSBTYWx0ZWRfX6mzkmbcKFpH2 6Qa9dhnMY2HR7okKUMKka7PIz5IN7V0XvFag1MkB+nRgyTvZnKN6W4yBiVLoNkeO+Ai4URgoCA8 A3foJ8SiMzLTQecB7DgiMpviOc3TAmO8RACxbkM/KWywtIQGV7ULRMU9f6X9NfW1KrctN0qqAKF
 aFgLNPjdAp1tV+xKxxGJntWgs9LbvNAQWFNiAQ1PmbkbWLBeEv7wENis5DRJDm5B4I62yjxKT40 IgAdVm35LsRaMBiwxKoZCr9EzopPAHYMms59kWNpElhe4BjYVfe//AbP0g28MSzeddqdzrdsoAh FPXt6LuPHEuXlt8/EGpvWvzV7P+mYkAIFHbMb+2NG7WOG80ztxJOYv96AQOxgViLkDModx55mPU Br0QUQ3S



On 21-04-2025 21:56, Ross Philipson wrote:
> +static inline int
> +slr_add_entry(struct slr_table *table,
> +	      struct slr_entry_hdr *entry)
> +{
> +	struct slr_entry_hdr *end;
> +
> +	if ((table->size + entry->size) > table->max_size)
> +		return -1;
> +
> +	memcpy((u8 *)table + table->size - sizeof(*end), entry, entry->size);
> +	table->size += entry->size;
> +
> +	end  = (struct slr_entry_hdr *)((u8 *)table + table->size - sizeof(*end));

remove extra ' ' before =

> +	end->tag = SLR_ENTRY_END;
> +	end->size = sizeof(*end);
> +
> +	return 0;


Thanks,
Alok

