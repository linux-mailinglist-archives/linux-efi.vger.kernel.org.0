Return-Path: <linux-efi+bounces-1900-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B33A998F6ED
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 21:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762C62813FE
	for <lists+linux-efi@lfdr.de>; Thu,  3 Oct 2024 19:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2BD38DE0;
	Thu,  3 Oct 2024 19:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mm9ZhaFQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57971A726D;
	Thu,  3 Oct 2024 19:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727983181; cv=fail; b=Q4gYmTTKMoyYADM9pFPK2Ok8GXDFKCbNvgAiNnRHmWTUxQkcDRuZRTXiaMK1ei//SrZAhYDVGRq4gUqtjAajVdi/wiAwWhiqeUrMmGPFs9KmFtpANa7Qo+KkU0NCaNA0sDsSyegjiBEv5qVUfc83Pwq/+p+i5/PYGp6mcc1M//c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727983181; c=relaxed/simple;
	bh=cJS4evBxuTQQDlBwYCTC6JMtmT5J+57ohzmmCgpjwFQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=N+elFza3dvy7TANxfiTEiE1GInsBBBTvSun2NbmxwYmHUOrnSxI4eZy/cz14hm2i4Dm++EF56/Cj4cNz9IrW8bx2HafpJbiYI/g1Gin8cOU/u9pnn8nBgJKyHAPZADYLDWc9y+iNXl2Q5bF/2kmnnob1Ma2LuBWNagfQxYEd0D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mm9ZhaFQ; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R5Azy9JWOfrtCOl0ldCHgqJXfIxa6zJlN736ScBLl/x5PVaW4QoS56Rzsg4UXSuihgxPTfaRJ6Z0/4//KRMhKHmWoxRGUHGbWEgetfe32XJJIe5Si6TFBPYydBYvUSDWJbAcuEs70npU281vnDCHTZQ08QaKJAE5fLRp+Mg24qzp6Bkv4ig2UeeQHIhPvoGE6hegbFoKcr5LX9T83JobPTfTUoIrnracYjpiBTLV9L5HlmMZSa+MN+UCmxtvFkRR7jhzbw8O+EySMORtDg+3KPga0mWUQpnpRKGJcwWfTWUsobYu4RA6rLagd0aF+EhQkn+mq3s/2eeeuMz/1UfSvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kst0zfRp20mvpbe4vI02VStU1gJrEQfHLI4xxL2DcBg=;
 b=aHlTP3JK1emkl3ULQoqPhj7A2qJg/WnLSpCGqyccPC5R3fu+NduBj/RLaeFswEgrMrYNSwv8w/20n39f4ZfhRJh1UQInUbezut81NwhJeXXTQEUJbc9hpF5DNV2DEiERv3zGUL2vr2AGL35Xz1mRoJ6Ny6LkFjyEjbPeJGdUs8Xh1leEUC0uK48FyHDReMb3zgEU9SMyQg9wC/DGge7TPFpXf4xgg4jR+FGKvJg61Aha8SDpxmGDJa30131s/UU4EAUUDkc5zGTH3iDN1S3wYWP4ppbhT5+UftHLNml0uELEGvhq0kNEp13nYQs7+y+eQO9g6ETV+qcN0jqaDWQHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kst0zfRp20mvpbe4vI02VStU1gJrEQfHLI4xxL2DcBg=;
 b=Mm9ZhaFQ3lHI93Qn/Mlyv3azL1lXGcFuPEc8cKtMQIDY5nI2ucdazVxndkL+beHqYU9Qw70Vq5gtpmVKjw8pL4kl2w62gbn2r8oEUuggMq96As4p+2N5Yvb6S6rQjYpYxkIing4CRX9t1jYw/b0I+hrJ8ylS27jeD3WBEtgrybo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 19:19:36 +0000
Received: from MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3]) by MW4PR12MB7142.namprd12.prod.outlook.com
 ([fe80::e5b2:cd7c:ba7d:4be3%4]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 19:19:36 +0000
Subject: Re: [PATCH v2 3/4] acpi/ghes, efi/cper: Recognize and process CXL
 Protocol Errors.
To: Fan Ni <nifan.cxl@gmail.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, Bowman Terry <terry.bowman@amd.com>
References: <20241001005234.61409-1-Smita.KoralahalliChannabasappa@amd.com>
 <20241001005234.61409-4-Smita.KoralahalliChannabasappa@amd.com>
 <Zvw0SnS40Rf_jWbB@fan>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <57921df3-6b02-583f-c863-f227ca8103d5@amd.com>
Date: Thu, 3 Oct 2024 12:19:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <Zvw0SnS40Rf_jWbB@fan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::16) To MW4PR12MB7142.namprd12.prod.outlook.com
 (2603:10b6:303:220::6)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7142:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bfff41f-b42e-4675-1de4-08dce3e051ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnBDbXA5U1o2UGF3VDJYK2FlVGcwNVhVck1RZXd4dnJOOW9SQVJoQ0c4YjBR?=
 =?utf-8?B?a290cXBLRTEyZlBISmRqNkJic3VhSE1nRW1xM1BlMkx6d0wvK1Z0V1pLRk9G?=
 =?utf-8?B?RXRtV1drQkhZQVQ4Tjd3NVBPQ1c5QXgya3Zhb285VEJXUmprY0ZtRUZhN0Nr?=
 =?utf-8?B?TVpOcCtMdFFJQmttaVkyaDFFVzQwNlhFUnRIVFo5cjZ4QTBjR3BuKzI4Ylc2?=
 =?utf-8?B?amNjSWVOVlZ5RzhZRGN6UzIxbWpNOUphSjVQMitGVGJqb2M1WGM1RWMvMFc5?=
 =?utf-8?B?Vnd4Mlh2RzBaOVBadWdxUExxbmxxcUFJRGx0RFcrR2NCSXVnOVoxRmx3Y1hX?=
 =?utf-8?B?VDBEdDFaUDNGcWVUcFdIY2JId091aVRBQXhCVDVmZU5RVWRJaWdLZVNrbURY?=
 =?utf-8?B?SzFGald4dHB0UzZIMFZtdTBKekh1SmtKbkFVbE1nSHM4Y1dZRDR3YjZxencz?=
 =?utf-8?B?YzFIZXJKc2hLclhyTXFHTWhPbW44QVhyUGVCd3pIQ01RWjZOR1ozdFNlZkNx?=
 =?utf-8?B?R3BhaEVTemVkNkZIZitURmVOYlpmRDRRTEtuc05EVWRLdXVhK3pQRlRsa0Vh?=
 =?utf-8?B?SHRPeUUzS3Q5bm4zMzVwVW9kY0tkOEozeHJiUm5jRkpqN3pOYmRReW9PRnV5?=
 =?utf-8?B?bENCVGtMMjhhVGgxOWdwcnlDdUY5WWFQdXdQQzYyYVB2WHpNd0lGL2ZISkhK?=
 =?utf-8?B?dDhBdXUzcVFwMERvWmRIdkJCRDVRTmUybTMxeFNBL2tFZzk5SmhFdkdjb3RT?=
 =?utf-8?B?MUpWanlqM1RYL1JrTE5pdkw2NG1zc2VwMEFJRGhKb2dCWC9vT0UvZ0NNZ2pN?=
 =?utf-8?B?MUFJVHR0WXF0UEcydmxKaXNYcjhZRHZ6Z3JLOGtaazZZYkRqeXN2cVd2R1Mv?=
 =?utf-8?B?Rmx3dlNzd3E4a2lXVmVNZzRzdFRVSTRGcng3K3IxekNaSmM1eFQ2NW93QThZ?=
 =?utf-8?B?alN2eHN4cGV2c3dnUTdTM093NHl5VUVlMkQwWVRXWE5EVHNmZG1FaHFsazNY?=
 =?utf-8?B?VGNlSmtsRC9RNFQ5K2RKaGRVZTA0NVZHS2lDck1POVVMZGxFOUdnKzQxTWFY?=
 =?utf-8?B?eHVaZ3V2RnUrdFZWa0I5UFA3T0JPK1VJL2xyRjNZMkwwY3VDRW5mUnNSNDdl?=
 =?utf-8?B?V1l6bVRWS3FXVlhHOGRKZ2ZZYTgyeWMvdjlvWnFkUG1GcGhia2VoVW5OUmRn?=
 =?utf-8?B?TDFrU3U1cVpqQURpb3AyR3RaQTlobkFObVVYT0J4UjJHTWtXYm96WjVZQjdu?=
 =?utf-8?B?QlZNOHdPWmxZeVVxb1NGT2dNS2gvczZVU1FsT2pFS21KZnZDRm5rSitoc0U5?=
 =?utf-8?B?TTVzOUdvSWlVdGlBL1phMUtUdm1JMVI3SFBjU0ZGNXVHcko3RUlKcUJrSkQv?=
 =?utf-8?B?Rm5KUzZPZTlnS1BsWWk2K2VxWHQvU0ZIV2M1NW55djYvQ1p3cy8xSGZtcFV4?=
 =?utf-8?B?MVJGUWxhRHNTb21NbllvcVFjMkxLaGg3S2ZSUW41REF0WllVWjhNWmVtMXg4?=
 =?utf-8?B?SUtFUGhnVDJSZmR2ZldNMTMzNmRDUjZTeUZLVzNSVWxvenc3K0Z1SVRETkEr?=
 =?utf-8?B?WjJOZE90NmIrNUtwbForTU53MVhuNi9mU3BqVFB2ZVFFNVM3c1lBcHZRRXpo?=
 =?utf-8?B?OWQ1RzRlNkdUcHBxTmMyS1NiRVdwVnJTajNsZGxHY1hYWnMyZDJrWnVWVnlw?=
 =?utf-8?B?dGdXcWlqVXI1ejk2OEtvMUtXazBIMlRYd1JaNFpQRlloZFFINHNKVVl3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7142.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UldCQWo5M0VFVklxcWxubkE5bG9DUDc4blRWZEhjZHp2dmFzZ2ZDSkQ5NEVz?=
 =?utf-8?B?OTJkcTV0alVFdnNkdEwvZWMwaE9VaTZjWEJ1WDRldUFyM2JRYWRXTitYL2ZW?=
 =?utf-8?B?NXgxVEduazVZZ09MUnJ1aHFNZU9yTVZtSG94bllLYXh0bks2eTFTMDMvZGxt?=
 =?utf-8?B?Qm1tNUdsbnlnZ1djWVQ2bWx0dkFWcDgyU0JZZWovZ3l6MFc5Z05xZmVrMGJ1?=
 =?utf-8?B?cXpSWFVpV0p6N2pBbWdYSGR5Umd6Z1dwdkJCSDUyQWdCK1hNNXRZQW54c1BM?=
 =?utf-8?B?MkhnYUhDUWNkMVBmV3cvR3Z0d3ZlMDhIWlVWcGZyb3NYbWlUenZFYnNackxH?=
 =?utf-8?B?ZUMvZ01pV0E0QjJuOG4ydEo2RG4xWjFKWDk1WVRyVGtlczNtK3lxemdNNjVD?=
 =?utf-8?B?TDg1WmxtdHgzQlBvVmJSc3ZZYmhTY1MvdHlrSWdYRDVNbEd0akRMRUZOdnJM?=
 =?utf-8?B?cEtuOGp2TTJydWl2d0FZSCsvQ1MxKzdtSEsyN0d4dkhCd1FJMjdaK21KektJ?=
 =?utf-8?B?MEdCNzAvc2ZGWkpVL2U1eE5sYXVIWHVoamtlMlQ2bUZuY1NtZHVOaFIwNjdT?=
 =?utf-8?B?WHNYZUU3bDA0V1BYcXVhSUg3Q2JWdHRSS0U3dFJSQ3hMVlNxOEtZdnhvM1dj?=
 =?utf-8?B?enU2S1FDeC9jS2FwaWQ5SDcveFc2RWlMMTNNTHNMS25lRUlKZjN0WFVZMVJ2?=
 =?utf-8?B?dHFRckJIdEs1ekxlY0hhR3ZVY2NpTjBtK1VSY1dtdTRBRmxIbFpwbThZUDlt?=
 =?utf-8?B?QXNwNURydW1VMWlqQlY0bmU2QXRmZnIzTDNhN1BsU0FhYUVxaXpvNmEzcUVV?=
 =?utf-8?B?VUQ5RUpkUFh2dHd4aUMrUHl1Y2todHFhL3dCQ1RIZlRabXB4bkoxUmdvNmVK?=
 =?utf-8?B?R3VVK3NVSVI2c2Jabm1zclBjUUVTYVNNR1JWRXE1bUZobUI3bE52cGZ1WFR1?=
 =?utf-8?B?UnpaOUY4TXZCZmY3UkpiUmxtUVBOdnloeGUyUjVwSGlzY0ZaWGVFTnJDK2FW?=
 =?utf-8?B?Y1cvckJpQ0hneWxwSVd6QkNrSHEyZGN1S2E3ODM3a2lFUU1FMjZrbFZWME1N?=
 =?utf-8?B?Qm83WHRqT0FxeWNBc1laS2t4Ui9Uay96TVNCZWRZTit3VTVXeEZXRUxqWjA5?=
 =?utf-8?B?MU9WUElCUzltV0dUa1I3MWZWTGVZZ0IvYU8zbjhkbDlZZC9rSUFXa0J4aDhO?=
 =?utf-8?B?OUNjWGFsSlNOWUV5eVJQTUhoRTl2Vzhjbyt0S0hQSjNLKzkvT3J2eVVlSUYz?=
 =?utf-8?B?UHJCSG9PUWtlZmVzcEY3YU4rckhZeDdQMWgrSE5CZVhid3h0azBWZmlGVUF6?=
 =?utf-8?B?TkFmbm53YnlsdGZuSFhtWE1MK29RbWJjV0RuSkFYZlZDQlVlcXl6TGpreTY2?=
 =?utf-8?B?K0E3NkJsMk9wZ0FkT1lSRllZbHN3V0VLWXkzMG4vVjZtRnZWV0hjWEkzYVB1?=
 =?utf-8?B?andpalo4NGdJNHpsTjRNdnprbEREZmpCRnVKWFA0TC85WXdYZ1hNdUlna1U0?=
 =?utf-8?B?dGs4RnF6RGo1QUZXbDF2amYvaEdsZ2pFMjBtNHlaVnQ2ektBRk02ZUFJdVVr?=
 =?utf-8?B?K0VPTndDdHNRUm0vSHFDMG40eUhiSWlGNGJ2WXJRRGxRaURkNEVkajMxUE9k?=
 =?utf-8?B?alFFV0g2ZTcwdU15Ky8zTSsrRWVISlZMVi9KK2prNTFJczNrblQ2ZmxMbWZV?=
 =?utf-8?B?TTFrYWxmdzlXbldnWjh5YXhKbzE5cS9tQ0RueEJZZFBKTzd1MzVCQzdJMDJQ?=
 =?utf-8?B?ZHRmOFJtUmo4SnlCYjlOY2hoWTB4Zkg2WTBFWlJNMlhZS0VLRHJyT1ZGWjI3?=
 =?utf-8?B?bDh3R25rVWpZdEVuQ2pjL2JxV2ZvVUE5dGpRcmdhUElUUUoyTmFjSkN0UUN3?=
 =?utf-8?B?OWs2N3loendVWTF6WTFvQjFhMGpSZTExQkV0ZmUwZXowcGRGL2ZpaG9YdG5N?=
 =?utf-8?B?elJaQ3dBbnZnVHl6UWg0VUdZMUlac1gveDNTR3FLTm05S2JSM2FBRldFdDRN?=
 =?utf-8?B?Y3J2YlR3bGl0bXlwTzhpTGZ1SVRHWGx4TEFyOE5SWmlYREQ1c3ZSOWdDL2tt?=
 =?utf-8?B?L1c2RXlHcG9iSzg1NXJDQ2dsaXFoc29kQ2Zhc1BsYjJKNzRJUWQ3Zk5WZWw1?=
 =?utf-8?Q?y9TTQjPPgoDSGweVG5gxqA1ug?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfff41f-b42e-4675-1de4-08dce3e051ea
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7142.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 19:19:36.7141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2k1GtCi+TD6fdvh+3HqREPxi/SOGmu9dkzjc4leDEq96MdEhfvfx8zomiX62iwgojTFrbdasxko6y17NBiXCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673

On 10/1/2024 10:41 AM, Fan Ni wrote:
> On Tue, Oct 01, 2024 at 12:52:33AM +0000, Smita Koralahalli wrote:
>> UEFI v2.10 section N.2.13 defines a CPER record for CXL Protocol errors.
>>
>> Add GHES support to detect CXL CPER Protocol Error Record and Cache Error
>> Severity, Device ID, Device Serial number and CXL RAS capability struct in
>> struct cxl_cper_prot_err. Include this struct as a member of struct
>> cxl_cper_work_data.
>>
>> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
>> ---
>> v2:
>> 	Defined array of structures for Device ID and Serial number
>> 	comparison.
>> 	p_err -> rec/p_rec.
>> ---
>>   drivers/acpi/apei/ghes.c        |  10 +++
>>   drivers/firmware/efi/cper_cxl.c | 115 ++++++++++++++++++++++++++++++++
>>   include/cxl/event.h             |  26 ++++++++
>>   3 files changed, 151 insertions(+)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index ada93cfde9ba..9dcf0f78458f 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -717,6 +717,14 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
>>   	schedule_work(cxl_cper_work);
>>   }
>>   
>> +static void cxl_cper_handle_prot_err(struct acpi_hest_generic_data *gdata)
>> +{
>> +	struct cxl_cper_work_data wd;
>> +
>> +	if (cxl_cper_handle_prot_err_info(gdata, &wd.p_rec))
>> +		return;
>> +}
> 
> Why we need a if here? It seems the function will return anyway.
> 
> Fan

Yeah, it doesn't make sense here without 4/4.

Thanks
Smita

[snip]

