Return-Path: <linux-efi+bounces-2791-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE0BA33138
	for <lists+linux-efi@lfdr.de>; Wed, 12 Feb 2025 22:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE0281889E8C
	for <lists+linux-efi@lfdr.de>; Wed, 12 Feb 2025 21:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C64A20103D;
	Wed, 12 Feb 2025 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MPAE7zpW"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7343A201018;
	Wed, 12 Feb 2025 21:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739394288; cv=fail; b=fMNXGtbSVz8Oz+v5LJtpnlrWYKqaY6YpMMIyww1AjC9ezmBUH7eyPfdtzxmCPQQMoa7wB7j1t+EQ/VzCRC1g4XnQIato+MnUJn2D/KyMBb/nV2ui575IT8ghLQ8smnvX8LWIYo7jkKZahOLbmmwhKll/jV9eM+CykVDdjTmLwX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739394288; c=relaxed/simple;
	bh=zvnIAft2kZRV0wjBtGS5gw4OB7rj7yXrDFkRcO28XOQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WeUVeP/zZ8o6omc89Fw7CDN1Cu0IWkB0AvIq6HAIXk2a1HViHOrgX1WVYEoamAkFFX4VB9Se5gzf7bne7QO7gmSksT80xvEgL3/pKOaLBF5dVzw7xMZWnwzDNx+HDpDtRD7RTR9VXZvrPWzAODMa962Ipj5Lq+lDEnhj7Kk566g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MPAE7zpW; arc=fail smtp.client-ip=40.107.95.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CphTrzSbAqth1JvmV//uHrzb3IkS9thB/nYysSYPbny+fwPYdnx0oS704b1LudEb3xKjfrIeeN5bqXPt5Ihe9aPgMCDLa7M5aXI1PVmUXCeJRU4NY+4ZV3LdRnBPiujC8+o1u8ykvplJtYkVpHkgzwATuZnzVcC+1XDuLlcNcksYWORO/ZXl76FfOwHxrSHS+Pn4tGGNf/Sr5ShauqFrI7xRBqONtAiceI6rFK0QP6qkRYawNWhSdQ3OREx6wvVN/rJ9SLoOhAnLwx2dw1aGCu5nLIvdE3ci0lZwkqo1Nzc0151MTiBHnnBeMCjl/HZXa4rU6lTi080mQRk78PFN8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LAzGgRlWQrZ+0RujCnQwLk6OeLt/LcR72TfIcvhw544=;
 b=gBWkkqWMukZTpTiDKOTjuzYSj25d336lu9dWkissIytoAcWvPvTm9Sajv9JNB/xMfawge2vmCr0v/3Nbl74rebTjA4EDAxHB02yA4nzAXXMbx+rsLr1L7jnGwBb1QasULrbumifm5QY3/1NkafgMvWQWPuc/XjvR9LxnX1R/oGV+CiAp8k0Via3fCVbt2IiYEoOuoudzbAbZqtek4F5dSZhWK2zP59dBj/XAWhchnbyWkGPl6ktKQOmcN4qZun9iPBFw397Lsu3l2mnXj41ywVVaIcsJNQL01MpgNb3GQxgoM4W69ktzAkHXt/SioL0cj0uZNW4qacVdQR5A3ozBxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAzGgRlWQrZ+0RujCnQwLk6OeLt/LcR72TfIcvhw544=;
 b=MPAE7zpWeZtgLMa7uW3Q6kbd2rfpo1EMiIH7zoaadXZUQ4UHSkgeXiyI5LxKc6AihAViU8sMaqIeHcf/Mz7Een/VUBvnWfWe4eQDEEI3pZ5oACT8PH+sVlNQmy9uv8ra5XcSjYp30F0ZzxyMrbmWTfmsBLuv02bjMpW2RgcsY58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by CH3PR12MB9220.namprd12.prod.outlook.com (2603:10b6:610:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 21:04:42 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 21:04:42 +0000
Message-ID: <ab7d50b3-4125-4449-bfd2-eb04e76b0010@amd.com>
Date: Wed, 12 Feb 2025 13:04:39 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/6] acpi/ghes, cxl/pci: Process CXL CPER Protocol
 Errors
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Terry Bowman <terry.bowman@amd.com>
References: <20250123084421.127697-1-Smita.KoralahalliChannabasappa@amd.com>
 <20250123084421.127697-6-Smita.KoralahalliChannabasappa@amd.com>
 <Z6ES_MZy2FuRsfjF@agluck-desk3>
Content-Language: en-US
From: "Koralahalli Channabasappa, Smita"
 <Smita.KoralahalliChannabasappa@amd.com>
In-Reply-To: <Z6ES_MZy2FuRsfjF@agluck-desk3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR01CA0068.prod.exchangelabs.com (2603:10b6:a03:94::45)
 To MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|CH3PR12MB9220:EE_
X-MS-Office365-Filtering-Correlation-Id: dc7a2619-0baf-467a-7b42-08dd4ba8dea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rmtoc0lwWCs0eWYzTGUwV1M2MmRNVVpSbGUwRHhpQy9mVGdxbUs5WmFTN3Bo?=
 =?utf-8?B?SWtmS0FVMVJGWFErWVB1ZzQrNjFQWG80ZzQvc1IvMFRjcWNSMEhYVWpGOG5C?=
 =?utf-8?B?VkFNVlFIY3BIV1lHZmhSTlJiVkJXNFNmZjVzQ0tiSThTUXNHMXF5M2xoQXNa?=
 =?utf-8?B?TWx6TTUzQi81NHlZaXVhc1YyalB3alJrNVJ3MTYrTmxheDlaRmduT2EySjVC?=
 =?utf-8?B?R2xocTFRSEJ4azBMVkx2ZWlMeHg0d2xvRkRkTlBjdE5Fa01jRE43cEFTSm9Y?=
 =?utf-8?B?RVZ1UEJ2RWNyWDZaVmREYVU0VU9pY0MyOWtURXphVkVzTWFsRkNNOWZoWmFC?=
 =?utf-8?B?ZlB5T3dwVmJMYjBYakJ6cElKYUhKVFVWakFGa09Tc1VYZUdTdlk0VEZrMkEz?=
 =?utf-8?B?OHNKeFVnQm1lNHkzbnJ2VDVCM2VxVW1SZTFiZ25TeDhuVzcva3M3QnBpY0Fk?=
 =?utf-8?B?Q1RDcDkrN2piZEo5SXhaRkgxYXduWGxuQmhRaTNMQkxFcDBKanJ0eGdWSDZj?=
 =?utf-8?B?K0VzK1libWd1VHd4d2pVVEkwL2toM0hmbkc1Tkl2dHo3ZG1HTGF3NnJrclU1?=
 =?utf-8?B?a1VrZjB1YnAzSVNPeGkzcWJ4d2o3MUIvSjJyQ0VKeUtLT2xDTmo5NjE0dGh1?=
 =?utf-8?B?YnFUTDVYNExsb1lpcjFlOWtoMXpVcWZKQ05lM1NGQUc2dEpSWDJwZ1RlbWFB?=
 =?utf-8?B?TkR4VmRYSk5LeXpSVTB1M2JLcEVDb0lLZW5xbXdEcEVhNGwvYmNka2h6VXRa?=
 =?utf-8?B?K3VkZGhOQWFDVGN6K2l0NVowWnhOQUVGQjlFTVVGZkJscGFZUjdJc2Q1Mnow?=
 =?utf-8?B?QXB5WlNLTXJSZHVJcVU1U2NQZEdtNWNVY1ZHbHd5S3hlZVVLVmNWa21tZXZ0?=
 =?utf-8?B?WDRVVmVHUEsyUk54VVZMN2paRWNCSDBQYmluSU1RZmtlMFIrdFNZL25IR1Rq?=
 =?utf-8?B?YVNyNkpoaytwRDFNaWtDcEd4Z0w3V08vQnV1WElCamptcHRuUi9KUDI5WHdX?=
 =?utf-8?B?Qmt1ZVNHTElhYUJqTGNjUnhodytKRTdTcERCK3UzNUhoWm1HOTJrNzRFQzBS?=
 =?utf-8?B?VFA0NGxqMkZ0VDFrRm9oN1QxWmZPWm9rbXIzRmF4ZC9mN05NcC9UaTB1S1U4?=
 =?utf-8?B?ZFIvQ016Z3owN3k1T1ZZK25QaGtxd3N3SFgzSUhIUVU3K2wweDQ2NzAzdndD?=
 =?utf-8?B?RTMxT0hONis1bWJiMWZia3VUNzJkREJ1dDZYSVV3Mm9nRDJwT05jZnNjQzky?=
 =?utf-8?B?LzVHd3RHNHhpNHcwL3lhNVBMM2U4MDRIUG9scDVuc1A5WXU3emFWZ0dNaVRU?=
 =?utf-8?B?ei9ESXZ5ZUlOcjV5ei9yWk03Yk1zU2tMOG1KUTYyMXl2WlRya3ArVkU1S3Rq?=
 =?utf-8?B?RG8zZXZKV0pMRmFYZGRvS0FKOTQ5YmhYVHJHU2Jna1ZUL0RmWnRMVWdIUzIz?=
 =?utf-8?B?NDgxSi9OY3NES1ZlNnZxTlYvbUprbjFVT0FHeStIaE1wVWl2NnpEVTd0YzBI?=
 =?utf-8?B?RlZMR0F3RE5zaXJUdHE4b0ptWEREcDBoQlY0ZWs3RU5Wd0paeC9yRW10cDMy?=
 =?utf-8?B?NXZpWktjNnR0Tm9ZY25lSGlLZ25VekZlWSsySC9ZMGtHQnB6VFJMdkF0NHJT?=
 =?utf-8?B?RnlFUVlpVkwyaGN5Ky9rZHNUblR1QlhTaER5RlRsSzBRSDBOUkhrc0lYeTJZ?=
 =?utf-8?B?ZXVORTRhUVhQeHlDNmF2VnZ5OGR3MWRMVkp0Z0FKUDIyN3VlUGcwMGRadURr?=
 =?utf-8?B?NW92TzNDK0srZXNaRUk5MFVyUGZSZUFpWFZ3dDZTWG5oRDRlRWRmY2FybDlY?=
 =?utf-8?B?RXNRN2cwWkoxN2l6ZHlnamh3aVNNdStMT3FpM1NGYlpGWlRraGdZeUwzSTVQ?=
 =?utf-8?Q?wbHla4BFqr1qL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnUwRGF1QXFXaml5UnJRTDlBcUZIKzBESWpXM3lZaXl5MUdRQ0MrYUVtNmZD?=
 =?utf-8?B?bEhmMnpmemNYZWJ0eEpiVVJQeEhjSFk2L1FtdmNKYW11MXhLZlJHWW96K3l4?=
 =?utf-8?B?Mi9zT28rTUg2YUt3N2pCNkU2cnZqZCtrd2FMb1RxTWd3emxhTlpWMFFsUk56?=
 =?utf-8?B?K0ZIRnMwUE1BN2hzWnBGWUVyci81S1RhTy9GSXN2VFlqZk1HY0hZUzc2V2M5?=
 =?utf-8?B?SHRJWVlVY2s1TWdveGtEM0VObDZoODlKdVd3eHg4Sytib1BTRlhhNXNHSjJZ?=
 =?utf-8?B?L0tCekx2b0ZRVklEMHg3UmhNaytIY3BYQzdlUmEzK1cvVm5wWHVQZWFzSjFo?=
 =?utf-8?B?aXhxbWoxZVRJOGRERGVtaDRpMHJCeDc3M1h5aEg3VThDVUE0WmpTZnp1eUdO?=
 =?utf-8?B?ZlQza2R1V0VDbkUvbnNEOUtDZmZRck5OaHdrbHdyNkJtWk9ZNEQwNmp1TkE1?=
 =?utf-8?B?akFOQUJRQXR1UkdUajJiSnVxVjcvV1dlQ0RXOUlCaXBHNUdHTDM0VVdia0dP?=
 =?utf-8?B?UENJRE1jWitaNmp2b2dHVnFCQnVDZ2N6SnVSTlNQMGtXVU5PZnhKOXgxZ2ov?=
 =?utf-8?B?WlF2aWVLb2dPTUhZS2xvUTBSeEErUkE0OVFicy9PZmdBQ3B4MEdDWDV5OThR?=
 =?utf-8?B?MXEybmVQRi9lWUZsbWlTWFhxTzB3bUFVODBKMU1XbEFqTU5vdWVvUW5EaFp6?=
 =?utf-8?B?MnlsTStEUFBSdlRPV0JlT0dTTnhlbktWaWF1TTF4bElWY1FBOVpZWlp5cHcx?=
 =?utf-8?B?bmVvZnFRdHdSR05sV3dxNzAvNERyc1pqdGhMTFp2SVZaYit6emJmVDNtQm5O?=
 =?utf-8?B?ZHlzaGJFRS9jWEN1bWlXTEhzd3JqaW42N2VOaVRaTHJKNGFOeGp2d2RMbjcx?=
 =?utf-8?B?RkR5TFMxV1NuMTdsY0FPTjhsMVRvcXIvZW9FajZHQUdoc0d3d0ZQbHljTHV3?=
 =?utf-8?B?a295WmVGN01kTmhrUTRyYXVzM0M1WDB2SzlZaTB5WnlGK0N0OWNWN3YzTmow?=
 =?utf-8?B?S1Q0bWJ6ZmgyeFo1ZkRMeWhkYllWSmlNdVZmWitmTGJmK0Y3YVRtbzBwS3Fp?=
 =?utf-8?B?ZVh3UGI0TWpzWGJwckRGL3Izc2NPdStHN05NR0N4L2JucDhocTZkalkzSGR0?=
 =?utf-8?B?eVRrdnNwVzJwUTZNdXpOMkx1QTljd0orODROVy9GRGdYVExsaWdqSjgzVVJV?=
 =?utf-8?B?VGVvQ1hKMjdRdXAxdnhyeDk0QXdqRDIyQ3lPN3E0cituY3gzdnJlT2x4ek4v?=
 =?utf-8?B?WXg4emVhenhEQ3BWaDB5YktQZWRNREhIbi9ibVhyM2E5NGdSWGxpMXFBTWUw?=
 =?utf-8?B?SVN4MXRHWVgxOWFUb1UyRkNER1BITUhpZWN4OVBmZWVGblRoSWgzVHRMVm8v?=
 =?utf-8?B?cDNZQ2wvVUd2YUF1VndBMEt2d0NHcjh1bzlWdCtTTTQ2T3VVMEpoQ28xYlJs?=
 =?utf-8?B?SUMvR1ZkK2l5OEEvTHluUmR4ZlVmZWx1eU5sNGVETnFKK2RlNGI0QlYrWklN?=
 =?utf-8?B?M3p1M2o2aDZ3RWdHREN3UzBiSFRkOXZPOGZvNStiYmhjRkpCVHF1WXVOZC92?=
 =?utf-8?B?QXFramU4WWRad3l5NlZMMzVteUVub3NPYWZmb0VRYWkwZUsyUUxkdy9WUEtE?=
 =?utf-8?B?eUVVaUlIMnl1WGJzOXBHM245NURsQWg4L3R3S1kyVmMyMEMzSnphdlVHYW84?=
 =?utf-8?B?Q05mdTliZXp3WW04RWJlOGxBc21PeDlDUlJTR3VtZU4rS2QrSDJIanlUTGtC?=
 =?utf-8?B?bkRXRFVwVGhBaTh6eFRYU0s4VnVVTTd4RWhZb0Z2LzhEWjlhdTlERXJyaHBk?=
 =?utf-8?B?SWh6NE1henJ2ZkswKzBQVzkrQmZyL1pIWVVRUGZDR0p0U1Zqc2VHWGpsdmo2?=
 =?utf-8?B?OUtwTDVDbStqRUFLYU5PSGE4SGRIaldXdm9kdDRUdGFFc0VlTGZJUHY2aVNT?=
 =?utf-8?B?K1RjaDQveUI1M1dQT21kZWdYMEhPTi9wNEVPdkVaSlM3bDNLRWNNSjZZcXJw?=
 =?utf-8?B?WnJkSnJqT1RXS0sxTUFpby8xeVRvODdEV3doUGVNYkM2d01acUJYZFJ2TXAz?=
 =?utf-8?B?RFMxaWZEdEgwK3E4a1dGemFYY3RUZUgzSitIU2VwMlhhR0tZSDY2c3JCOHZq?=
 =?utf-8?Q?VFypEP+xnqRLQ4xGCpV9q/GCg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc7a2619-0baf-467a-7b42-08dd4ba8dea9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 21:04:42.0012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8evr7wAUzhQwcp1TWFFygWmkALRLcO5PQFTL5ywx+wNJHc/TkD4S/HPlNh+b27npAcFquxQ7wkCo0SqoUHJwuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9220

On 2/3/2025 11:03 AM, Luck, Tony wrote:
> On Thu, Jan 23, 2025 at 08:44:20AM +0000, Smita Koralahalli wrote:
>> When PCIe AER is in FW-First, OS should process CXL Protocol errors from
>> CPER records. Introduce support for handling and logging CXL Protocol
>> errors.
>>
>> The defined trace events cxl_aer_uncorrectable_error and
>> cxl_aer_correctable_error trace native CXL AER endpoint errors. Reuse them
>> to trace FW-First Protocol errors.
>>
>> Since the CXL code is required to be called from process context and
>> GHES is in interrupt context, use workqueues for processing.
>>
>> Similar to CXL CPER event handling, use kfifo to handle errors as it
>> simplifies queue processing by providing lock free fifo operations.
>>
>> Add the ability for the CXL sub-system to register a workqueue to
>> process CXL CPER protocol errors.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
>> ---
>>   drivers/acpi/apei/ghes.c | 49 ++++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/core/pci.c   | 36 +++++++++++++++++++++++++++++
>>   drivers/cxl/cxlpci.h     |  5 ++++
>>   drivers/cxl/pci.c        | 46 ++++++++++++++++++++++++++++++++++++-
>>   include/cxl/event.h      | 15 ++++++++++++
>>   5 files changed, 150 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 4d725d988c43..289e365f84b2 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -674,6 +674,15 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
>>   	schedule_work(&entry->work);
>>   }
>>   
>> +/* Room for 8 entries */
> 
> Any science behind the choice of "8" here? This comment is merely
> stating what the #define is used for, not why 8 was chosen.
> 

The choice of "8" was arbitrary and not based on a specific rationale. 
If there are better heuristics or considerations for determining the 
optimal number of entries, I’d appreciate any suggestions.

Thanks
Smita

