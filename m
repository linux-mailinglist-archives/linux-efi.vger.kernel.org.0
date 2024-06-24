Return-Path: <linux-efi+bounces-1291-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9722915993
	for <lists+linux-efi@lfdr.de>; Tue, 25 Jun 2024 00:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3165C1F21E91
	for <lists+linux-efi@lfdr.de>; Mon, 24 Jun 2024 22:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64FF1A0708;
	Mon, 24 Jun 2024 22:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5IVqHju/"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDC713C901;
	Mon, 24 Jun 2024 22:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719266680; cv=fail; b=B6QRPObfkgIwpPSAvqlC2osfb+lC9OMHZAu3QIRI8uejTIG8bS1wBSwi1L4DRpuHxv0DepTOFqY2HmZ0l7V9adDKeGhD93pdqCamkTv4RVfY9CIT/f1DVOlLJiEBCk1Ol9GASkePlUc7i9jzveXhgazSzqduailCAyjbRqltT7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719266680; c=relaxed/simple;
	bh=cjsayKQs6jWOxhvX384v4JtghPNnbS5dJz9PGIPCXy4=;
	h=Subject:From:To:Cc:References:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=BbN/ucoBKhvd71sfn7KKK6kYTq/UdbbA/cSdf9+QuSdVYd8ayKsKtq096FE/TqWef92tp368TmYLGeEOjs897eZcExfA9MTN5wqszZOUi7ZvVf1v30de8lV/pRfrHI5saa6U6GwwmBVu/Wj5KrC2brOvBeYLFZ9Pgl5AmkKws0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5IVqHju/; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8QPMsdGyrTkUl2JEBWXshVj75beCcgrGE+Hl5MLxshkEL4As+Tq7b4A8LsQKscB6Pk/h16S3Vn9/B3Pv+DbEvQCYdl+Utm2YRkYGLBGkCvWKOqllgdiascUBT92096+oIiS/ANHHi+nJhif3kYklAMr/KRs94Pd106R2+rCk3ulrfsB7JWHqucAjtlZsnfWseAAWw9J9T1oq+O+aENB9OUw0H4/o8lOIY9Q1ZwRobqChhgzTUuyVfJ0ikUFgfudg/0rgUpVuD0VR/JmZ5vpo27l5hOx4AcOC06jGq3cbmdwXayJzXGvOockXpy0vRp8sqOiWlLBxYYfOAq1PSMDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tw3+kKJECFyIzv5CQozSVb0RMpfrKipEGH5QcUlrG9s=;
 b=RyKILDKujW0GsON/c2ei0YF35uWiveDZJoGpAjOGpcC35fuAQ1ksTG52JEnNF3sXYwOq8asW7fjTAZteNJHg34/vcOTOegxvw1tyweJJNQKlgCVleYolC+aqIsxzfVV4UP28tXP1+90iSmgxbsWIqlj2XuEvzS6JGlVCngqD1wCflcA9gGlIm0YXzbv7EilhFI8PJ1Lf34W5qZb4/C4Gqk/MGT5m67H2V9mRS4SxUWWKf/qpHtTvXnmblECCU36nD73cfp7WWm2Fhc19GgieYn0YZEy1pvHOKuealfZaLm3Ag2GR2LuZjM2RWBPN+LV/BRjGlU53QoIp4b9rVF8esw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tw3+kKJECFyIzv5CQozSVb0RMpfrKipEGH5QcUlrG9s=;
 b=5IVqHju/ZcrD64HEQ/3j9pI2tUYqMhaUuiomV5+Q+l1+kAvEKnkai3S90+xM3dg4fEZzUgaFBoeglZSP7dvmQqapiv239Pk9VUFhI1jbLzAbf3Lzs1j9t60VLd06ko9Mx4BEa4FcYKLJM1+Qh1d1wLeB/QcHX87kc7lck8AhkuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by CH2PR12MB4294.namprd12.prod.outlook.com (2603:10b6:610:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 22:04:33 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::56a2:cd83:43e4:fad0%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 22:04:32 +0000
Subject: Re: [PATCH 3/4] acpi/ghes, cxl/pci: Trace FW-First CXL Protocol
 Errors
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: Dan Williams <dan.j.williams@intel.com>, linux-efi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
References: <20240522150839.27578-1-Smita.KoralahalliChannabasappa@amd.com>
 <20240522150839.27578-4-Smita.KoralahalliChannabasappa@amd.com>
 <6668e6d28e9bc_310129473@dwillia2-xfh.jf.intel.com.notmuch>
 <73a9acb8-92ba-cad6-3dcb-d2479939db99@amd.com>
Message-ID: <875e49da-4a2d-ad89-dc84-2fbe2f1a60b7@amd.com>
Date: Mon, 24 Jun 2024 15:04:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <73a9acb8-92ba-cad6-3dcb-d2479939db99@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0049.namprd02.prod.outlook.com
 (2603:10b6:a03:54::26) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|CH2PR12MB4294:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cefbaee-083a-4fb9-3bd6-08dc9499a05d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qmtxa1YvTEUvOG5qaDhYTms2MUJIWFBERDloSmlselBjOE1xVis0NVFmVjZn?=
 =?utf-8?B?RW03K1hMOXV6K3d5bC9Ud1MyVEFxTkxMQzB2MlJYYi9Icm5HNW55U09DdkhJ?=
 =?utf-8?B?MDYyR25jMHdtRVBXOXVGcjVqOFFwaWJRalZTdUFoODJuYlJSaWJFZGpxaGFY?=
 =?utf-8?B?UmRyalJrUGhrazFnT0JOL0tVdnRTWlNCZ3RwaE1JN2FVZnl6dFdkajFuK3hh?=
 =?utf-8?B?ZDBGYjdSaklDK1BadmFtU1VBTEtSR0FhbXF3TXpmbzcyd1orR1pLWUNNQVZV?=
 =?utf-8?B?WGVDV0xHdHAwaVA4U012ZUN6alFaaXBVRmVvclJuRzdZdmQ4cHIxQTF4VXpv?=
 =?utf-8?B?OG9zaGtTcjk2K2VrME5XN2lHUTFIZEFTSTdDWldyaFN5SkxXdWJxenhvSERY?=
 =?utf-8?B?Zk02RkYxRklMaUI4RDk2TEpXUW10RGU3NTR0ejBJMTRnTkNGL0VKYmZXQkFH?=
 =?utf-8?B?dzJ4ZUk0dkVuYnJtb1p6SVV4MXkxVndoamxCVzZKTzBXWVB6d3QyMWExWnht?=
 =?utf-8?B?YjhJeHYwaitnMDBsK242YjZVQzhJMTRIbWhUR1dDdXk3bTFha25JQXBvMVAw?=
 =?utf-8?B?dWpNYXY3STRSU1Btbi9qbVFOeVNXV2FxakN5aFZ3MHI1VXRaU0NneitMWm4v?=
 =?utf-8?B?SUpWeVY1U2c0SFROSUI4QlJoOWRESk9ZaXZ3L3RyTkMvNzY5OHUzeWpuT3Ew?=
 =?utf-8?B?YlQvWFZBSWFvU1RjVTZoU1dNMnJ2Y2VIdTdsZTZLVkJNRUhaOXJXM2dxcVMy?=
 =?utf-8?B?N1lhU0VSUmRtWE8xT24vcFBUUERyb1loNnRFcXVIbGg0ZXF6YlRlSkxTQmZa?=
 =?utf-8?B?dEozYUxrR3JRbWdEaURIRU9aWVJQaVE4ZnNmQXNYWXBsTHNkYmp4VnRtRTJB?=
 =?utf-8?B?SVNDS3F5STJpSG95ZkJPcEU0RTVRQUl4bGE2MmVvN3RhZFFQamx3WXRCNk1h?=
 =?utf-8?B?VGR0U0xDWGFpYVFQZElPSGFoajM1WGd2VXQyd3lWTGhNYVlyMDlObUNEeUpQ?=
 =?utf-8?B?YWRydVI1ai96SFNVM3FPWStNUG1sNHdnNWhPajBFODFWb2M4YTZiYkdZclB4?=
 =?utf-8?B?YWpqcS9JUjJWMW5nU21wNndDa0tGeFlCdHkxS2ZwemlGb0hMMVdsSXI5cVE4?=
 =?utf-8?B?d2xzRHhHMWpWTlhNdnNsMWRta1FyMXlYUk9obDkrVm96blNhc1VKUVllVGFD?=
 =?utf-8?B?cytESWtjSVNtVmNDdW9uQUhDMHUxUzU4WnRYL08vUE5tNXVJVzhQTXMyRS9x?=
 =?utf-8?B?S0haZG81aGd0MmZYWFIvdkU5S0ZwTTg2cE1PQ1RnUlpTVWxjdWludVRzd2pz?=
 =?utf-8?B?ZzNROTdKSDNuYUFmQ216dnNVbURvVXcrRGNvSlNaajU5bTc2UDVpSlRiUHQz?=
 =?utf-8?B?eHJHVzJiR0NlSnkyN29jd2ZJK1IxS3FUcEtNNnY4K3dBYnhBYjg5di9FcTN6?=
 =?utf-8?B?a25Kb1QxcVJRN2hsSW45ZFlVU2phbDNyaDh1Nk44OTljeEdhT0ZEVGd0b1Rk?=
 =?utf-8?B?ZTRFOXNMRklnVW15YzVMR05LeThHNkdCZm5YMXA3dEJxS2dFanp2RmVnWUpu?=
 =?utf-8?B?NHljdTRGaHFmM1JZTFpUZnEvd0JlZk5ERXoxSUczWVJ0TVBNQUJLMWFjR1Va?=
 =?utf-8?B?cXp2NVJNekkvUUhrYkhpWWlIeG9Ucmx1Z3g0YzFPYlMrNjBUR0Y1Tjl1aC9T?=
 =?utf-8?B?aDM4QVJTREt0RE8vSk0xNmpOU0FiTVpTa2JiR1ZESGJIRUY3Q3BkU2pSNlZa?=
 =?utf-8?Q?ACx/tZGGc3m2uCNWMlTUjM3QLc93OCvRIMmvaCt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDBsRDFhd0RxMTJaa1gvNHFDQzE0SE5lSWhURG1qNmpmWUd3WkROdHJieUlL?=
 =?utf-8?B?N2hUclV4U3p1ZXpIOUFVeEdNT1QrZkV3SER1Y0YvNUYwRmVtbGhsTGNXVG5K?=
 =?utf-8?B?aWl0VjRXUjJvbEgzbkpDM3VxK0k2M2lXQUY1NXhjK3BmalhkSFBHZFdlaW5M?=
 =?utf-8?B?R2NEZ0svUGMrTGFQZzhYMVU1QTV5TVhiQnRMWlFqWDRpc0Nuc2FmZzAxVWFN?=
 =?utf-8?B?WWxSQVdFUENVQ2JNc1hEby96WFh4c1BJZDFzcTlUYURJc1BIT0daYkx1bGJF?=
 =?utf-8?B?aGNlK1VtdXdYbFdUYjlkNUFNSWtzeVdNTS9UQWlPV2o3YmYzL0RkTVphUVAr?=
 =?utf-8?B?SCtWVm9iZUx2NmdFd2RSRE1Td1BOVDVLOUt4anYxZldBZDJiWUJLcHZFbGFP?=
 =?utf-8?B?UDhqcTRubWxZSUJKTDNySk44dDB4Vkxqa3JxNFF5U0JnTFdDSE5pMnliSHNn?=
 =?utf-8?B?K3JpWE9ubnZaOC82blg1aENOdmhJQU96WWUyNWVtaDdQZkczS01yWDRMK1E2?=
 =?utf-8?B?NXNyWDRIejNpbDdOOXRFRVNaaTYvK3BHanA1WlQ0VU1UeERZU1I0TkFnYlNn?=
 =?utf-8?B?SWRadXRwcDJ6NzNHTWZBTGFQTERzSnlnUC9qRDZKcU1DRHBXZ0FLZVNzNHZm?=
 =?utf-8?B?eE1vY01JUlZ4cm0yQlFLYlVLOUZLbUlPUVV4T0RTMEMwSVdkaGdveFhzK2Nm?=
 =?utf-8?B?OXpYZ2g5UmhmNjBzMk4vOXB4UGJMYlJlT2R3M1NRTHhxcUsvUkJLQkYyQlFH?=
 =?utf-8?B?dG5qdDYvc2dlMSs5QjUxOWdtMVJ4MU5RcGhSK2tqYURyMmMxYjlSTWJvVGRY?=
 =?utf-8?B?YjFVUHlTMGZxTGI3cXZ3b0xMRkJZQ3c0OVVtaHZ1bHo1WVl3d0hlTkVQL29i?=
 =?utf-8?B?MlI3azBhY1pMcUVqMDBIK2VBMUx3NHpjNDdGSDMrT1FOOWIrVkRkRjg3Uzl1?=
 =?utf-8?B?a3R4Nm5Jams0SVNYeFNLUGxmTUIwbDBQL3ZUWFZyenIwOFJRUzhuWFBoVTh2?=
 =?utf-8?B?MUg2a21TblhmNHA4NE85VEV6TEFTN3E0Q0V1bUVMcVFuSmE2eFgvOUk2MHNy?=
 =?utf-8?B?cXh5L0Q3KzdZcmlTNExPQkRYVS9KbGRwYWJOTlR6UisvQnJqdHNVd1NMSzNF?=
 =?utf-8?B?cEJlWW9tSG9LL3J4aDVKNy9Ga0NySHkwWE8xZHBBa25QdmFUUlNSTE40d3FM?=
 =?utf-8?B?N21jeTFqNVlnR1NJRElGZzlwWUgwYXgyMzRBVm5hOGVsaTdGSnozK0x2cVdE?=
 =?utf-8?B?VkV6TnlKcmI2dnlHengvczlaNk02OU5tMEVvaDdXK3BHUUtKWG9XL25SNk5Q?=
 =?utf-8?B?M3RoMXRLa3IvcE1naEZ5WTVOVERuZlBSbHR2bkNFYlZtdEVvUVA1UFNZZ2tJ?=
 =?utf-8?B?QUVUeTQzbWZXY1BhVVNhamo1M0RCQ1BzaXNiRkZXQmdBOE1hYnUrTTZaM3dD?=
 =?utf-8?B?cFkxbE1IbEd4YW5sNFhyQmN6M3grM1F3U2NPcnA3eTZLZ3d0RDJISzA4UWw5?=
 =?utf-8?B?VkpDc3lDK25nakN4MHA5TUo1dlZrMldTeHpDQWVJNnFJSjBzbnc2ZFB3K0dv?=
 =?utf-8?B?N3pVczBJQUNxUDY0TnFUMFNQc2psemVXR1h5ZkhybDhUVnFQR1lCZlV3NGt1?=
 =?utf-8?B?WC9iUHdmSU5ZT2Fpd1EweVFhc3QrcytvaTBpV3VWRUdnUlIzY1pOTHRncGpv?=
 =?utf-8?B?TEtQb0pIZzlUQTd5OE5QblZ2Z0Y0V3V0NVJMTVFQLzVFQVhjNlRTUUwwL1hh?=
 =?utf-8?B?Qkk1UlcvRFk2NERCYXd5L1hmRWE3R2t5Z3ZuRnFrVElkMGtGR2JBRjI3VXpW?=
 =?utf-8?B?dFZ6VUYrZktKSDRMZVRKdklzNjBTMmNCNU5LK2xwV0NQK3RHQnM2MTc4VGli?=
 =?utf-8?B?TnJ6RDFHVDZhZ0VLUWo3b0Zidko4czkzbDNUVSthUVdVMFltZVZxblBNVzM5?=
 =?utf-8?B?VzJ4S0lpREtSWnJmRDFFWlFGdWhRWWtCQjhuWEZEaGdpeXkwR0U5cERjOVV4?=
 =?utf-8?B?MmdMalI2MXl1STcrZ255aDQ4NldXYmpTUFUrcVFzT09wYUl3Mm1HdzkxN3V3?=
 =?utf-8?B?cVEvM1A2MkNGbmFLM2RvY203c2xWR1IxeDhPZmVvdkQrWExaUnZEVThKaUxs?=
 =?utf-8?Q?RYbjYHkvHXidZQqq1915S9yym?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cefbaee-083a-4fb9-3bd6-08dc9499a05d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 22:04:32.2705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujvZnqai2qp0zFvlM+o5lHEIPrjzYhVXmzqH1LQTtHN4G0IOC6TpHbLZRNE0DSrg3nF/BRqVvxRh88Rln2x6DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4294

Hi Dan,

On 6/13/2024 10:47 AM, Smita Koralahalli wrote:
> Hi Dan,
> 
> On 6/11/2024 5:07 PM, Dan Williams wrote:
>> Smita Koralahalli wrote:
>>> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
>>> CPER records.
>>>
>>> Reuse the existing work queue cxl_cper_work registered with GHES to 
>>> notify
>>> the CXL subsystem on a Protocol error.
>>>
>>> The defined trace events cxl_aer_uncorrectable_error and
>>> cxl_aer_correctable_error currently trace native CXL AER errors. Reuse
>>> them to trace FW-First Protocol Errors.
>>>
>>> Signed-off-by: Smita Koralahalli 
>>> <Smita.KoralahalliChannabasappa@amd.com>
>>> ---
>>>   drivers/acpi/apei/ghes.c  | 14 ++++++++++++++
>>>   drivers/cxl/core/pci.c    | 24 ++++++++++++++++++++++++
>>>   drivers/cxl/cxlpci.h      |  3 +++
>>>   drivers/cxl/pci.c         | 34 ++++++++++++++++++++++++++++++++--
>>>   include/linux/cxl-event.h |  1 +
>>>   5 files changed, 74 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>>> index 1a58032770ee..a31bd91e9475 100644
>>> --- a/drivers/acpi/apei/ghes.c
>>> +++ b/drivers/acpi/apei/ghes.c
>>> @@ -723,6 +723,20 @@ static void cxl_cper_handle_prot_err(struct 
>>> acpi_hest_generic_data *gdata)
>>>       if (cxl_cper_handle_prot_err_info(gdata, &wd.p_err))
>>>           return;
>>> +
>>> +    guard(spinlock_irqsave)(&cxl_cper_work_lock);
>>> +
>>> +    if (!cxl_cper_work)
>>> +        return;
>>> +
>>> +    wd.event_type = CXL_CPER_EVENT_PROT_ERR;
>>> +
>>> +    if (!kfifo_put(&cxl_cper_fifo, wd)) {
>>> +        pr_err_ratelimited("CXL CPER kfifo overflow\n");
>>> +        return;
>>> +    }
>>> +
>>> +    schedule_work(cxl_cper_work);
>>
>> This seems wrong to unconditionally schedule the cxl_pci driver to look
>> at potentially "non-device" errors. With Terry's upcoming CXL switch
>> port error handling there will be a native path for those errors, but
>> until that arrives, I see no point in this code trying to convey
>> root/switch port errors to the endpoint driver.
> 
> I see okay. What are your recommendations on this? Just confine it to 
> CXL RCD, CXL SLD and CXL LD? And then extend it to ports once Terry 
> sends patches?
> 
> Also, I'm not sure about FMLD. Should we just drop it as of now?
> 

Since, Terry sent his port error handling patches, shall I keep the 
above check as is? That is schedule cxl_pci driver on all device and 
port errors with mention to be rebased on Terry's.

I'm slightly doubtful on FMLD though.

Thanks,
Smita

[snip]

