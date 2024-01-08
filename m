Return-Path: <linux-efi+bounces-358-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E85C8278E4
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jan 2024 21:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89790B22B40
	for <lists+linux-efi@lfdr.de>; Mon,  8 Jan 2024 20:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FCC54F9B;
	Mon,  8 Jan 2024 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sv9xmm4E"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2075.outbound.protection.outlook.com [40.107.94.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E338054FB2;
	Mon,  8 Jan 2024 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSWw9Kh8/Acmtl10j0+I/S5zq4PLgvYJFxpiKar6aHAWClqlxGVEyTfZpd8Aun0daPq9odEo6xZhzT9acdRfDdsCiNosebvAq4tplKv8LSSUSnt1sB8p2IuYe9MEBoVp+x1t3rPvvy+sKCLVm0+1GGsATwV2wT5CAobDgsVviL2dIyfTFGulrxe5fFslcqvKewQtUk/MljkDQkGiBoFA8qa6G6Jrkt1JYAh24VBrUivm5oa8OuzBFy2Qhgi9HykUElCQzU/IQ5cLJniY4Np6eTaVTdTmM2eh86WhMU304VOADQ68pYNEFO1BavbnCwoyu3WUEKCt9Pd+nn4dE1qleA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyn8pCe+TiMP9tjLGPsuD6vaIIXxGxs64H571YY9CbU=;
 b=ij1VcCorDwbUDgvhi0/pfrpU/Td7INDBDNAdjB4JlwK75480EjOCGZBri+Am3eT3ZTrInamJxMeT8H3Q9Ngn/uQEziQabIly16SN50oXKaq0IyAlmSFcTeALICVOg83fWEAGdbbO3M0FRAgqZJGYoYKHzKxjtgzq2s+ZahQIarcVaGSOOYieGuzjWXC5/5AHscc4OYiD9XHu+KP0N6sD9R2ru/S2MV3N8HSaUMhF/96Gstbyy7L7M1IWQpVywUb8a4aOrU7wa+7rYuODo+j3SEqXQHvuDjsHPIOHegYu6Ai5hFC+QLWT6kre6ZsXQIIrxFDAuD/6UQt21UDn/bskUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyn8pCe+TiMP9tjLGPsuD6vaIIXxGxs64H571YY9CbU=;
 b=Sv9xmm4EI4SwrButj0NeXddb60iUzRUT/yiCRVhNzG74lTEC55TjeXmIkbhsvwu3gL8xoYgMMHMLNI0dXmij5fQ4ESCJLHJDax1bBJM3hGNGpbhJ+LahA710Vo+Q9/9JkSRUnImycgTvLdh/XjCXBIDsrnV7u88YQJXWtbu7RtE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by PH7PR12MB9102.namprd12.prod.outlook.com (2603:10b6:510:2f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 20:05:01 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::bdc7:f7b9:a4fc:b793]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::bdc7:f7b9:a4fc:b793%4]) with mapi id 15.20.7159.013; Mon, 8 Jan 2024
 20:05:01 +0000
Subject: Re: [PATCH v5 0/9] efi/cxl-cper: Report CPER CXL component events
 through trace events
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Shiju Jose <shiju.jose@huawei.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20231220-cxl-cper-v5-0-1bb8a4ca2c7a@intel.com>
 <20240108165855.00002f5a@Huawei.com>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <eefc5888-4610-8e39-61ed-2d84e9ebf255@amd.com>
Date: Mon, 8 Jan 2024 12:04:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20240108165855.00002f5a@Huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:a03:180::21) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|PH7PR12MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: d2e05a28-0ada-45f3-c477-08dc108517fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3tNA95qV3w72nY8dAWIkIDAYTW6PspGTlMmCungJWZwy0WFJo/bmhB+Q6fmrBC6ac0vzfRxT/+M6xfLn1MkHI17rJmC2g3ApCZaPN2PxHvQSC32f03R0LnHQvOKtFZrp211xUSJ0NfqdmzTr+wixKefCLemYewUrGewFWQhLbpDRVSk7fWeoSaLmBTzdtOn6Y/hjhgxUlKhrPOWqLC2gJEoY53kf6YN8/q35jNcimIL2s9laVSFtDQXgGY/4HSO9hzeYRw+GCx4Wd94EwAK2jHXzA2c7XpGrD8Qhz2G0PWQMzKcCSkzX9Mps5S+eiSIWEFCx3VATf01810pyxy/S6EPkNjPK7S0RsgtroarbK/j2bFpkSnxUt5ISTpygSKGQOVI5dNQ69/vUTENPNdYGeuv+aNJEdhlE7WKCgb+PYH2L3Ff4hq8bm9mqRxfZjVowjCJP7ZEv2fQqI718ncaF0DtCFCtxhBjQ5TSYJSorDr1C/6ahRaq5W9RfG/0L5yUQgt1eWHdZqmVMrHwlHCgW7aEIiHhF/MjKdGa10eyMY8jLCMI4UMuMzne6rQcaXeq87UTuv4RpKUzAAl8dm8rC2sTVg7uSEulMDMSGH2SAf1NiRowriC3p95BZeMuWeNfoUrt3lLAeanunyntGlPq8YjWK872gQFfk3EwuQYtpmmTsxXBNKgyITpEd+hY24qm7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(26005)(53546011)(2616005)(6512007)(6506007)(478600001)(6486002)(6666004)(38100700002)(86362001)(31696002)(36756003)(5660300002)(41300700001)(2906002)(7416002)(66946007)(66556008)(316002)(66476007)(110136005)(54906003)(4326008)(83380400001)(8676002)(8936002)(43740500002)(45980500001)(505234007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mk1WL2c1QWVjbFBmcnNlazBURmsrUHk0L0hETVhhWGlSMzVtMjhwcWlsMllv?=
 =?utf-8?B?RE0rTUFpRlRjcE91TEpUc2xPUVo2bkZnZmNZYnMvZ1c0elNwdG50RHZpWmY3?=
 =?utf-8?B?SXZUd1N1a2Q1bm5tL2ZVMzdWUVdyblM0RG5qRmkydDlmKzAxYnJCdU5IRVJF?=
 =?utf-8?B?RWllQlFBR0N4eCtOU216TUd0UDNXVnl2aEhldGZLN1lUdlRWajF2K3Q3Rjl3?=
 =?utf-8?B?R3AyM01sL3I2Y055eHRYenYxQkFoY1R6aDJVZVQ2SGRoWkJ4TVJKZDZ0Tzc0?=
 =?utf-8?B?akxHTDNPbGtXVFZyQ0U4U1NabHJQTk5ZMDRLb0MvaVE4bUNVRUFFbERWd1pX?=
 =?utf-8?B?bzlrZm5rZHFVbFhYUmRSbVlXWXlEREp1a2RrUFNqSGh2a3pqci9wZzdEcE01?=
 =?utf-8?B?Tm1BT0JPcm80VE5LWGVHU3NnZHMvNmx0VEdFb0kxVUM3WWFySjY1ODBCVkc3?=
 =?utf-8?B?TEp3REV2NURpcVBuNHpyYnhFdHJnb3E1Y0RucDVwMmZRd3BnUVZ1RTRUQXVr?=
 =?utf-8?B?L3NtTGJGUTltdTZDRmd4U2ZpTHhzQXo2ZzBZOWk4cXNGS1ZrYkpFOXVGUjVV?=
 =?utf-8?B?T3B0WmdnSGtycGVXcXhpcjNYN2RoR2huNElXZDBPNUZjeXVIQXFaVDRyN3pr?=
 =?utf-8?B?cllla2Jickdlcm1qb3ZmVmhFMTVEdnJQN1NJVUJhbzdwM3Z2MEFxY3N1WkVl?=
 =?utf-8?B?SHVJMHhwdStEVU4vanB0a3p5akpXcnhJaU14RkFERmYrMjRZSFJ3cS82Vk9z?=
 =?utf-8?B?M1YrN3MrYlRtaUNiWFJaeFltMU1Nbk9vY1dEdkNFcXA0NkRqZ09DYS9HclRh?=
 =?utf-8?B?aWprVG5BZFlkM3IwYmZaSndlZnlUQWFCUDY0UUFXOGNmR3c2OUI0QldtSll5?=
 =?utf-8?B?UWdWeWtZSUpMNjRFMmpPbmJaOUtpZFpQTHorL1NzVGlGSUR2emh1OThWa3B4?=
 =?utf-8?B?Y2VsVWYzR3JyRnpLaTBrclJ1Q1ZHZmRtWThMSGhoNU1YOEVIRU03WUY3WExt?=
 =?utf-8?B?bzVYOHVSQzZKTnZ0VDVaaWNiSHBQRm5idzZONTVUM1ROdUNIbXZ4ZVVsTzNB?=
 =?utf-8?B?c1FucWhuNUFYK3RKTlBZeWpPS1hiaTlrUm1US3pSYUw0b0diQmV1bGVZazR2?=
 =?utf-8?B?ZWVibklhcVdiSllmWjFJSDZjbGVGeDdwSUJTVnhaL0dqRWlFVDdCNytIelp0?=
 =?utf-8?B?V3IvT3AyRGRyaU1lVXZxd09CaG5uYmJwMU03YkNiQlAvOFUvVEdJZFBndGk4?=
 =?utf-8?B?anBSRk9WWGVlSytKR25NUzkwZzd2dkNkRkRVSHZGL2VibGFiOWlFOERKRU1Y?=
 =?utf-8?B?eHlSU0Q1NXFGeklHUFJaUkY1dU8zUHBlRVpIOVRRK3NIK0YyUFk3QmVpNUcw?=
 =?utf-8?B?ZDFzVjQxOE9FYjVTWUFwWjFoRnhocFZlbHVDd0ZGYUczWWEwWHZBZTZla0tS?=
 =?utf-8?B?Rm4xN3gzK250cTh4ZVZNUWw0akpiRnZvTVZGUVZkbnBDY0liMGt4SWxHY1BM?=
 =?utf-8?B?Q1JiMnVlT3Y1QzBTZzhqRkxBdXNIZFJCdm1USmxQZmVPL3IwSUVtUDJ1Z1Zi?=
 =?utf-8?B?eUJXYWlUYnhyRmxXNUJxeWFZbFhic2h6eGltL2pWdUUwMC9oOTJBdi9Lcmtu?=
 =?utf-8?B?YnAzM0VIRFBVRGxHdzhqaDlzSHBCM1NlNURaK2FsYmFheUI4TUNWbnZ6SEcv?=
 =?utf-8?B?czBOSnZWOWp6RldUeXNLRHcyMllqRkZYbVJtTU9iZEVEWG1Ic0hqNWhZL2My?=
 =?utf-8?B?aCtXUUxZWEJadW1wa3pESlo2Sk1LdEd5N0NhcnhxLzNtMnlFTWgzTXlsWWJI?=
 =?utf-8?B?NlgvUGlOVWlCWkJLZGk5RGh4WDFVMnhOVlFVLzV5YnhCam85dGllZE9jOGo4?=
 =?utf-8?B?QUl3K1BYckJSM25ScVp1cklpSWxXNHBJYnF3aHpxYkcvblg3RHoyalNhd1ZY?=
 =?utf-8?B?b1o2cVc2UkJTZEUvb0x6MUpRZFJ0V00xVnAxSWduaVFQbTN2S05xWTZGTU53?=
 =?utf-8?B?cVpqR1ZEY3NPdDFXUDFtYUJobUlJQTFBZ2V3SW55dk1oYnFuZ2o1V2VXcG5M?=
 =?utf-8?B?Y3F1VjVPbHUzTGJBNTMyQjhFOExOeGdBMWVIQ0xNZnRxbWJoQURWYkp0RHlo?=
 =?utf-8?Q?h40U8QhcYUitgsu4afYf0FFIg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2e05a28-0ada-45f3-c477-08dc108517fa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 20:05:00.9853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tK4dcW2UX58rx1KlvCO1GaKrb7JCSG2OEKDBfwWsRpDUiO6YDBvCZqyTJXZL5Nk9W4VlTJigzvBxPDJXQXwqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9102

On 1/8/2024 8:58 AM, Jonathan Cameron wrote:
> On Wed, 20 Dec 2023 16:17:27 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
>> Series status/background
>> ========================
>>
>> Smita has been a great help with this series.  Thank you again!
>>
>> Smita's testing found that the GHES code ended up printing the events
>> twice.  This version avoids the duplicate print by calling the callback
>> from the GHES code instead of the EFI code as suggested by Dan.
> 
> I'm not sure this is working as intended.
> 
> There is nothing gating the call in ghes_proc() of ghes_print_estatus()
> and now the EFI code handling that pretty printed things is missing we get
> the horrible kernel logging for an unknown block instead.
> 
> So I think we need some minimal code in cper.c to match the guids then not
> log them (on basis we are arguing there is no need for new cper records).
> Otherwise we are in for some messy kernel logs
> 
> Something like:
> 
> {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 1
> {1}[Hardware Error]: event severity: recoverable
> {1}[Hardware Error]:  Error 0, type: recoverable
> {1}[Hardware Error]:   section type: unknown, fbcd0a77-c260-417f-85a9-088b1621eba6
> {1}[Hardware Error]:   section length: 0x90
> {1}[Hardware Error]:   00000000: 00000090 00000007 00000000 0d938086  ................
> {1}[Hardware Error]:   00000010: 00100000 00000000 00040000 00000000  ................
> {1}[Hardware Error]:   00000020: 00000000 00000000 00000000 00000000  ................
> {1}[Hardware Error]:   00000030: 00000000 00000000 00000000 00000000  ................
> {1}[Hardware Error]:   00000040: 00000000 00000000 00000000 00000000  ................
> {1}[Hardware Error]:   00000050: 00000000 00000000 00000000 00000000  ................
> {1}[Hardware Error]:   00000060: 00000000 00000000 00000000 00000000  ................
> {1}[Hardware Error]:   00000070: 00000000 00000000 00000000 00000000  ................
> {1}[Hardware Error]:   00000080: 00000000 00000000 00000000 00000000  ................
> cxl_general_media: memdev=mem1 host=0000:10:00.0 serial=4 log=Informational : time=0 uuid=fbcd0a77-c260-417f-85a9-088b1621eba6 len=0 flags='' handle=0 related_handle=0 maint_op_class=0 : dpa=0 dpa_flags='' descriptor='' type='ECC Error' transaction_type='Unknown' channel=0 rank=0 device=0 comp_id=00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 validity_flags=''
> 
> (I'm filling the record with 0s currently)

Yeah, when I tested this, I thought its okay for the hexdump to be there 
in dmesg from EFI as the handling is done in trace events from GHES.

If, we need to handle from EFI, then it would be a good reason to move 
the GUIDs out from GHES and place it in a common location for EFI/cper 
to share similar to protocol errors.

Thanks,
Smita
> 

