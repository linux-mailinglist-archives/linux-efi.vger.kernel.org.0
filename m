Return-Path: <linux-efi+bounces-2934-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00949A57262
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 20:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11031188A0EF
	for <lists+linux-efi@lfdr.de>; Fri,  7 Mar 2025 19:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9AC25485E;
	Fri,  7 Mar 2025 19:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y5GQ3Cfv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GeeRa85P"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B7724FC1F;
	Fri,  7 Mar 2025 19:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741376657; cv=fail; b=D66xsPHt6Tjm+rxcc6B1PVQ1yP9rvydVCvcTJxvQPyBLYVHSNTpGDVhvhE/OjvOewwG7ph3rwqPDMnvvliUcwCFEm0GjL+Mgm4c4YSDNFn7p4dzNGinGhAUQ3R4EnqTXR27UZLmVUE1AE1GnRWTQmdMMFUZuqsvWpyLo7A9NiuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741376657; c=relaxed/simple;
	bh=6gefaQJ/jtEHr8GL4ujmXnnzueFdm0hUkPk2myqwN5o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xcl1sHaACMNgV/BfS70DJiYKnOsmhBF3lnqWrr5lqA9XvaYkk0sgLotKZmK8owuwTbL2QxbDOFbOPgTIoP49n0WkUWViXmq/v4yEyPB59wAKqOeTBGyjzoL/+A4NCVZBbgSTey344N0tediBmDOFlo33lL/BEu+o4fvaN8O1WLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y5GQ3Cfv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GeeRa85P; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527Iu5b7011069;
	Fri, 7 Mar 2025 19:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=qM+aS8aPxQ864uOOHwErpSpxztTEB5cg2qctHhYAlso=; b=
	Y5GQ3CfvvoIP7Y35KqYsZ3gczqfqRPrXHNhJLmk8q0jiO8I2w6+zxnOireVgHuwi
	WQLxCoRkmuJ9SoXFS1UUdoqtMDzNdlwUhqB4r6ZxQmiKI+1h9RlvbQQYxzeGZqoi
	6KUROKZLO2yeJA2DvnIQlvFRuGnSblEPiwgLts0nfC6NXuDObKFssterr6eOl+VT
	YOUzmfKWjR9yraEyidSdxLUO6uismriuTY6BflUEJ1k3dErhBbRK92SuDcljROkF
	PriaD3JNQN9hjeNTPohhPqRB83YEYOPABZbYxEG3uBKihWXmeheTT2U82Ai3gAqy
	6Jy3npsCy50AD5GJGeVpMg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub7d1yc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 19:43:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 527JZ7hA003236;
	Fri, 7 Mar 2025 19:43:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpdxrh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Mar 2025 19:43:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2PVaFoiCTqQy+TU7J45gMpEwC7BpzksQVNZ5A6QMFFCbhDBOH6b0WvToE8+mRC0qvTZbHPHOQQR9+gRbQKii8hAKk2xSSiwm26W/CLPeRvsNUfHp6E9qw0/wDmt41x74ng/4nkgFQZocRJAg3HEjAfDVxThiy4jkUkivm9WLsRbn9ZFeDowiFitgFzLn3QilKOMNK+1cm+1sIcOo6D8Em3F68UPPDPLmfDPNjmr9eSDVywGA6JE7nfExJXlbxn591b4S7E5IM8YF5Nb2FhEyjFnD2DJ6jyXSQETBP6CIiUmDIvydwhyhgXwjSeRN9+QNI6EQNa/Ucu10uv9B9qreA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qM+aS8aPxQ864uOOHwErpSpxztTEB5cg2qctHhYAlso=;
 b=q55yU3WtXlQ0W1nOekOo/2S7XSlQ6Clr+3YM7jQpP5TWZMBygrT8+gp11XOg00gLgfF2OhyyMgLlrNg78L6ek+k8DRfBblZNrTSbA6kCjHIqasPZlkMD1M5+v9ThyYCLsiBV9F+S8i0O9ZEhx3GZuMzMqFrkLP81n0PMnuywVlPoDxi1fHpgn7zrmVkRY/FSK1un8jwANr2a5MWWWrINmqWMYvnYpYCwgP/5ndnTJ7ljnnJw8PO8JX4tI/lyToazxLiR5hiOwveZTgUMkMyuEUYeM1oz5KZGg9I0GjjTnuDr82IV188B6x4GbLcat3fVIPEgtSkyWEPHUYO2p9fgOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qM+aS8aPxQ864uOOHwErpSpxztTEB5cg2qctHhYAlso=;
 b=GeeRa85Pg6I/z15CLooOkF3vamPYRrpAe1IQSKK8hAHbfULiE7cizhGOHRdU8MLQjSYbWfRo5A3Snx71fFybW0LnAeJuqKDVXpPPVP5zWcNb1BzQQ7JDZOXwXFjE1agoPrX/6gAwHsEn8g2sVSTCInvRQHiXjIP4Mzzlk7ClU4g=
Received: from DS0PR10MB7224.namprd10.prod.outlook.com (2603:10b6:8:f5::14) by
 PH0PR10MB4632.namprd10.prod.outlook.com (2603:10b6:510:34::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.19; Fri, 7 Mar 2025 19:43:04 +0000
Received: from DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8]) by DS0PR10MB7224.namprd10.prod.outlook.com
 ([fe80::c57:383f:cfb2:47f8%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 19:43:03 +0000
Message-ID: <bec4277a-3491-448f-9d27-dd10e549ad43@oracle.com>
Date: Fri, 7 Mar 2025 11:43:00 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 10/19] x86: Secure Launch kernel late boot stub
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
 <20241219194216.152839-11-ross.philipson@oracle.com>
 <Z8qaEdBD8wZLo-yb@kernel.org>
Content-Language: en-US
From: ross.philipson@oracle.com
In-Reply-To: <Z8qaEdBD8wZLo-yb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::34) To DS0PR10MB7224.namprd10.prod.outlook.com
 (2603:10b6:8:f5::14)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7224:EE_|PH0PR10MB4632:EE_
X-MS-Office365-Filtering-Correlation-Id: cfdf4b09-defa-485a-1bff-08dd5db0469a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDJwc0VURkE4MUZES2VRUVRZQ0xQZUExMDV0NVJnZ2U5V05Tckx1OGljTDl3?=
 =?utf-8?B?K1Rld3dkeCtKQlIzbUFwY3dmYVJJbklBbktDSUs2WWNWZzFqWHo0OXVwL1Q1?=
 =?utf-8?B?V0NRaE1pTXM0cWlSb3pySGlQTDdxTys1WGdvMXNnQzg2ZjFhY3Z4OENKdjdV?=
 =?utf-8?B?UWtTeDI4ODBUQUdKb0NGRXNCanBPOEdxaHNUOGRUS1pHVG1GTWY0dHVwT0ZO?=
 =?utf-8?B?bTBIR2lzRzNZQ3BKTWwwU1EzaFdhS0JqdExDQ1k3YmtjMUVRejVuM3Bib204?=
 =?utf-8?B?d0hJQnM5Rzk4OEhSNnZ2cFJZdTEvWkJaL2VHdnNYY01KZ1hyU3hmaWpLZ0l0?=
 =?utf-8?B?K01aUi9sMkJ5NkcyeS9OTm1Cb0sxSXdQOGVpSkV5Y3JaNmJZbW1DcysvNUpR?=
 =?utf-8?B?Mmg5RGlnV2E4dTQzbnVlbEZGblZQek9yWXIvWXVWZThVaHBEcEF5MDJmRWVj?=
 =?utf-8?B?RC9WUWVqRCtvYlU2ZjNNOXZQZkFtYUY2a3kvY0FDSkVQSmQvQ1NtdFVJN1p6?=
 =?utf-8?B?d1NmVHMzSEk2bmVRT3ZRYk9PS2wrWitxMHllcVJDWmdnSHY3VUdIUXRHK0N3?=
 =?utf-8?B?d1hGZjRHLzl4QktaODlNOWpMR21mcDdZQzFkOWVXUHVHY1ovT0NML3FDVmI5?=
 =?utf-8?B?ajk3RHl5ZUw4bEErUGw2MG42aFJPTFRDQkMzUlZYZ3ZZdEhRWWtlakxXOTNn?=
 =?utf-8?B?WmVVeTdBVit0SVdCK1pzLzJaQ3ZCdU1RYmJuSHZCWXA3QWM4R3hKeUZvWVl1?=
 =?utf-8?B?QW5MVnBzKzhoTFFhc0VZV2xDVmYwVkpzWmplQjlyL3RmU2MzWHVUL3ZKTGNl?=
 =?utf-8?B?NGpaalVjdnBHOEdTakVSbUlHeWJLeXZsd3JTSVA4cFFHZXpYMGZJazhnNjB4?=
 =?utf-8?B?L3AwSzgzbnFyS3d6MFc2aEtEelRQaXhSQkRJejNMTWhVcG9MeHpxVU9MdHNI?=
 =?utf-8?B?d09BR2Y2RjdHK3B6YjZoNjN3SkZVQmZOMVc5aEVNVE1iWHR4TEhza25hQ0tH?=
 =?utf-8?B?czk3QUVTNDVYQWNENlJwRmExQ0IzV09YR053cVpNTHQyc3RlV0VTMmZoYjVF?=
 =?utf-8?B?d0hBL0lnQTlWQXZTU1FRWXNidmV5MVRKNmU1bU91Q2ZCZnRYTm9rVlZQNEJn?=
 =?utf-8?B?Ym81NzY4OWJCWmtFN3kyYnh1OC9jVk94elJ6OHlsWGNqRmY1cEZ3L094Mllp?=
 =?utf-8?B?N1BmcXIvNWRuOG92dEc3TmwxVkV0Wm81YXBMYWl6Wml5NWZkbTFEL0pROTV1?=
 =?utf-8?B?SFh3ZE85NWNCSzNiQ0k1a1JtTExSNmU5MldiMEQzTUpLb2NGN25NS1p2elB4?=
 =?utf-8?B?cVZ3T212VE5OQjdKb3dpQzM4WThoVmgrWWVvTlBDOVdBZ0NUS0R0K1VHWlpS?=
 =?utf-8?B?MmhQQzVLMGNyVk5kaE9PajIwbU1pazBFWVJmaFpFdWMrSDUwc0RKaXo2eWZt?=
 =?utf-8?B?UXVXQU12b0x5bkQ0TlA4UGc3ZTRQZjFac3FGOG9HNzhPVGl1UEZOa1l5SHlv?=
 =?utf-8?B?cnNqSDFTQ215aG1JV2ppczVJTTFwa2VnRFRNZENBOWx1bGZmdm5GMno0aFJm?=
 =?utf-8?B?YWRUMTY5UEw5VW5OMjE5OEkrZ0daeWZSMUoyaUFYMnNQcU5aK0M0UUhnRjhU?=
 =?utf-8?B?QmRLMS92bHdTb2p6dUxDNksrUmJUb01iWVlDdml1L0MwWlo4VmFYaXRWdjVO?=
 =?utf-8?B?N0YxWjU2dlRrZFUvMzJsbjdWeERJaXd3RC8wTDVHUnRpSzh0VDFYWVllblpo?=
 =?utf-8?B?dGloUTV1RUk5aWZvYi93MFA5VElNdDhTck44U0NXTm0zV2hUQkQyQ0hpZExk?=
 =?utf-8?B?dWhKRE4yV01pekZUUFQ0eVdPUGg4dnVWSmhwOXBEK0tvWTNYNWh5cjlYS0Ri?=
 =?utf-8?Q?RE7ukljIsmgUS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7224.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDhZUWFwb041dGNPSjlkU2xuUWRzWm92VTlGYXRwU1RjTDdXVmttVksxNktT?=
 =?utf-8?B?TEN0NkpqV3pxVXY0d1R3NWhxbHpOenZ6M1VZd0VvcFg4M2dVVzYyMFVNTzBT?=
 =?utf-8?B?OEJwU3A1S0pnd3FwYVBSdnRZbkpDNDB5SVRkWEhVYWlPQnA5VlF6NUpRVkpQ?=
 =?utf-8?B?SHZCOFBHWXU3YVhzaWVNVGVDSEdoMlRkemViLzZtQ0xwNnJjdnpzeWo5d1JP?=
 =?utf-8?B?dnBoTDlmNnlmd0VTZjRwUmFXRmpQeFdnclJpVXRKK0tEQ3cya0lGNXpsdkpo?=
 =?utf-8?B?MENFTkEreDRxL2JJMFM0WTNlbGs3bmhxSVkwWUUya3JqalN2RGRMSlRCeDlD?=
 =?utf-8?B?ait2K0d2d0dsbTRlcmNnQVVnalZZSzdHRkg5UUJiNlZ4MmdvUElMVFdUYm9h?=
 =?utf-8?B?cUVWWDhReDVNOTI3L0hsTEcyQ0lUNzh6bjNOVGQyZVdtendZNGNpbURVdW1y?=
 =?utf-8?B?bkU5TnhwMnhHZ0NDOXFhK0dSTUw5UWdRVmRKekdTREcyUmJ3UUxUZ2Y1Tmhs?=
 =?utf-8?B?bldqbmdRTHJRbDZFVEdnNXVXYWNQNWhlN05PN1JXdGZIaVkwTDBJRkRyaEc5?=
 =?utf-8?B?Z0NoVUJCMzFDVjIxeUZTdklnbXV2KzFiNG9mWHh1MEk2NW9OUzZyYVpnM1F5?=
 =?utf-8?B?Y3BqRlZPNEFKa2wxRS9SWkgyblFYeUlXNWF3SG4yN0EwZTJhQkc3YU13VXpO?=
 =?utf-8?B?Rnk1bGRKcGxxWHJTOXA2SE8vdDl1VnJYcXJGejd4Mis4RTFuemhDSWtvcjRN?=
 =?utf-8?B?cTQzWVNoZElWc1I3ZzdWUlYyTlJrTHd3ZWIzclg3dHk2eGNvM0lnN045NUgz?=
 =?utf-8?B?eHQyZy82YTJlTW9IV2RtbkZ4M2pNVm1EUXM5Y2N1K0diUWNiV1lZMWEyTlgv?=
 =?utf-8?B?VGFmSjA2M1VSZkNRL3hpRDI0WmtBeUsrM3hxQ0ZnTC9Ga29rMXJKdTFUUGRS?=
 =?utf-8?B?OFZLZGU4VjZvWlZyczZwSkx2blFYMXRLSk12alp1ejhKbFJ0YmRocnNORHAv?=
 =?utf-8?B?OWtjSXNJdzlwOExqLzQvQ2xpYnQvSlRkN1JmL1hGR1FXQlN6a2NQVmtvcEl4?=
 =?utf-8?B?QTVoVHE5eFNWS0RrZXgwZjJRMXZhMFpmaFFTc1N2am5pQWhVZzlheTVRYWh6?=
 =?utf-8?B?S2cyTlpjMVMvem8wVWltYlBiOHRic0drR2hLY2RxciswQU9QNTRYalN0UWtn?=
 =?utf-8?B?QklNZnRwMVhPYkRWOFQvN3I1dTBGZkpYL2ZZTWRXc3kybHppV1YxSldBekhr?=
 =?utf-8?B?K3VoWllwZkpLVk5UMVVveGVnRlBEL2JCZ3NIRGRnbkQ5RHRORGY0VVIrK0Nt?=
 =?utf-8?B?Z2RqR25CMUhOREQxbER6cUZOODhRODk5emZtUDg1bno0alVlTVpDcVBKY0tz?=
 =?utf-8?B?SzV5czJySDM3K2gyQXFlT3pEL2JWbVgzT2FXYVdtMndIVm5mcEYzMGZuWi83?=
 =?utf-8?B?ZjQvcCsvU2h0bEZQVEVRUGUxTUluK3ErVVA0aGVPR1gxdEIzeUs0YkpqbTNO?=
 =?utf-8?B?c1U3ZmJOd3VYZFloOCtlQXo4UW00QzNLM0hGRTZoS1g5TTQyK25jWVoyVlNQ?=
 =?utf-8?B?ZWxibDhZTm1FbWRhVGQrYWhnSk1wdzU2anI0dXdkK25wenBiZ0ZDOUJqZkox?=
 =?utf-8?B?SExIeVdCK1d5Tm5IbTcrVHhmQ29oNmMrQTZQRktpQnRjMjlMNXh0T0JMYW8y?=
 =?utf-8?B?em9yYXNxNGVGcUR4TnBQcUF0YjZNT2pzakFPN3dsR25PYndEeFg4cW5uL2dY?=
 =?utf-8?B?by9tN0d2Q1VOZHBvZ29xU09lRjQ0Q1Fld0JJcnpFWnZRdEN0TU5tZGVBM3Yv?=
 =?utf-8?B?dmJQWGVHb3RNOC93cm4zSGJRWmhETzMzK244bi9kWnZmMTV1dWp1VCtCMnFr?=
 =?utf-8?B?Z1d6MXRTdEpyeGIxVmlVU3NkTVA0VlI0ZTN3SXhLdllTZjl6a1QwSE1kNUds?=
 =?utf-8?B?TVVlTi9SYjF2R1VxeHZTV2oxSG9PQnUyOFFoRWttaDJ4QnJRMlhEMWhNcXJp?=
 =?utf-8?B?ditmd0Q3K0YxYzZRS3BYd1NWSmljZDhSYnNLUERCaEVwaCt1KzN2bDNSczhM?=
 =?utf-8?B?RWd0WGkyNkpwcFZDR1REdXJvc2wwMGluTUxRRXh2QzdYWU90NnlOcGp1Y3Br?=
 =?utf-8?B?dHc1WE1WbG92YkRTdVBxUUMxSHNibUM0aXk2VzYxTU1ocnNhYTdzcXEwOXVq?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z934TFbC8HCjMZHwdVYjP3TytuvzHhFwtQVRcGvsyvnXeMhuNjHEq/IJMvdfmtRbenf4XvbwJUw512BCR23FEYCM1f8s+XWs0b50JoK24Tyj8JtUtrBtcdXYUMVtdKm2iBz5dMTYMbxdYENn3JxnfyrvBG8h/P4SfQh97vyaltodSGvvGb1F4AvI6rmUOHthOil9L63JJriIlV9HM8WVlFzQO4BYDj15rR1pF9dYOu0pOQheZcHrb76xxv81xbJViJ6guGMgnj13+3iDw5wzfLU05DBDNdL9iiEu6c3KRA1gZ7B99zypfEd/uAZsCRTlNptNduRj7FvxGUNono+z2Ehyq++j8CG6V2VvC0NTr7wFYcDm955TYeDnUQ7buOl/QQW/FUEoBPb76XBgCf50rVtP1dxJgBsxUXNZ342HVhY39OiUHliz11KUv9q14k2rd1/wzTo1/FGbPL14thXiXJ1u9IHZlHpt/hkzoyY4TyTC7huWNqbytmqtOIuFv8EbMuXw7HwXOhLNClql8gV8deqD8rAzu+A5PA5ZhPQec0oO4OTO+k0SQf1TyR8FgxnTSsc5FnEO5LqbnMOA4/ncVpnNuxOFiRJnhhcbeoHHpAc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfdf4b09-defa-485a-1bff-08dd5db0469a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7224.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 19:43:03.8194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vVuUeFkKBB3KsPlhN9ItGmeqL8QURM4+0Y1ZNDYg7ZFkDVFKsfqbkyBjvNydkVM5V53F49i0+RmWdLQnlKpsrkxAnmwDu+9dvQ7crQP5azE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4632
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_07,2025-03-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503070149
X-Proofpoint-GUID: 1Q4qOz3UIGDYgL48P2qSKhYmBskfYGXk
X-Proofpoint-ORIG-GUID: 1Q4qOz3UIGDYgL48P2qSKhYmBskfYGXk

On 3/6/25 11:02 PM, Jarkko Sakkinen wrote:
> On Thu, Dec 19, 2024 at 11:42:07AM -0800, Ross Philipson wrote:
>> The routine slaunch_setup is called out of the x86 specific setup_arch()
>> routine during early kernel boot. After determining what platform is
>> present, various operations specific to that platform occur. This
>> includes finalizing setting for the platform late launch and verifying
>> that memory protections are in place.
>>
>> Intel VT-d/IOMMU hardware provides special registers called Protected
>> Memory Regions (PMRs) that allow all memory to be protected from
>> DMA during a TXT DRTM launch. This coverage is validated during the
> 
> Hair cutting again. Check through patch set:
> 
> 1. D-RTM
> 2. DRTM
> 
> Pick one and use it consistently. Small details like this in the end
> make the overall thing less exhausting to read.

Will do, thanks.

Ross

> 
> 
> BR, Jarkko


