Return-Path: <linux-efi+bounces-236-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4064481796D
	for <lists+linux-efi@lfdr.de>; Mon, 18 Dec 2023 19:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEA371F23CBD
	for <lists+linux-efi@lfdr.de>; Mon, 18 Dec 2023 18:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBD25D72E;
	Mon, 18 Dec 2023 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wFI/A0sv"
X-Original-To: linux-efi@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DDF5D732;
	Mon, 18 Dec 2023 18:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WX6+dfZlekgYthzemwkbjiybg1SGDBbo6ur3KP5Y4LStMJHkTxK2+UU0ZGOH0sK5bLLdluji/3WTkyZSJSI6+Jf/dwc5/marHjWS2sPPqoFUa1hXKjeEABCm8F/retCL+4SOgm+XhFhqEt4apfEJ4lGkqft1b0dHHBkrVzYfOqcLdcOOB+s0mwAjsrOhkSwHLKFJdPjxEwpI6ReB6OiBM3VRpzIr8ErqBGUG3AY9cGRRWAW8mMzHXXmakrFTw10+Ka8NtBNDe6TLq2XtC32cDypP9wK0EyLrVtSQArF1zr8+d+gvjXmHYrzfvES2XRcocfEKzOMslFsY9P02XXQ6sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0TiCDvJMEelyFf584S0FTAM+I3ApNf8MZF5Mav20CE=;
 b=TYMys15Pb5UokprZzWPWvCFVIBpYGsSaFlTaO7bEg3VzJaDa7/0FmrJfz84H60c/YtLdY8EOx2hMGou+JNDm7mnnxadIdjNfeKZlTJpEUDWK2vYsDEubjI3GvtH0/oMSm3T2Z5z2R66V357Cdfggupe/cV5hDwGTT2qGrg5grSoGeDXO1MKWEGSSmHe1mxALomR82MaxzXABLRTNwXhoroX14d5nI5h52kMtwQnUGVVTEdp7XpheyYT6RAuwmiHtNaYIXkdcNu9WebtUJUYClrNkpU4mhavQh+SE2VE0JWFMeswGB4BPwSWY9v9iySVWWr7xExdfQ4mInU/FWIzQsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0TiCDvJMEelyFf584S0FTAM+I3ApNf8MZF5Mav20CE=;
 b=wFI/A0svZmQ+tT56B22ScIETCGINDIVFSMcjfrkd3vrl1QIJ5mWd+wScJFeWnQhWJV8bYe4+JWm4c+evRNkd9QvaqsDhCPUBr2LVdf/UrR7EuBYgxSF5XHAyLw9hhcTwBZG1WHpM4bb1UhbStGQxe+Y6qI0gjQyQyIBSmwfg/Pk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB2869.namprd12.prod.outlook.com (2603:10b6:a03:132::30)
 by MW6PR12MB8959.namprd12.prod.outlook.com (2603:10b6:303:23c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 18:13:19 +0000
Received: from BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::ea10:2f7:ef14:9c]) by BYAPR12MB2869.namprd12.prod.outlook.com
 ([fe80::ea10:2f7:ef14:9c%5]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 18:13:18 +0000
Subject: Re: [PATCH v4 6/7] firmware/efi: Process CXL Component Events
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <20231215-cxl-cper-v4-0-01b6dab44fcd@intel.com>
 <20231215-cxl-cper-v4-6-01b6dab44fcd@intel.com>
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <a32464b2-9810-ca9d-73e5-4ed4cf69fea0@amd.com>
Date: Mon, 18 Dec 2023 10:13:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <20231215-cxl-cper-v4-6-01b6dab44fcd@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0213.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::8) To BYAPR12MB2869.namprd12.prod.outlook.com
 (2603:10b6:a03:132::30)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2869:EE_|MW6PR12MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: e6321d2c-42b4-4a2a-5652-08dbfff502c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XzCjr3Znh7QS1QxwYzWHVfkCdoOz2ay/m/dojWUJQNMukPwu05wjO2Mejfcmxh4E72BNz9rJDERmduwx2R5iRCsbT0dEeoGaXFFIA9+zTCGWCG5rUXFAlwASb0GyNkGqz6t45PDZHaqcdedckqdTrd9WPfHOWVTq6+hXlPT193DxhdiL02i7CEzKhnKVXIFIUVRpsHJC5mSRQAxyEnm+Hk21Pwio9NnPWBUlkhoHEeBVxRoj1QaDxWF9VA0EWEkkvDX0wpkNtaN0fiEsRsdIcdA0VChAZJykGvXRuUg/En4s9QPsjj78/F05IdJmq+oiNzzllQpd9eLAnTWTyDx294xy2hegQfYbLki7JgYz80J1nufn3m61uGpqEVYSiU4Vgq1VMiEawUqJ27ByEctR3cxKcCYbU2NKhbHAGf7Xy5UB7enXd+e9IEP1fRN7n8tOrlwm7l/wEmgo8213ZFNs14t+ZXlp0BCletvKEmSzes/488/n/4swJUNYNeiKxC0ffoiaU8V9wYW0HHt5Y/5p13q/dx5YMkC5KaiTiFEY8cdLJzknV258TLYXdpIfC1SIivTtKDrtIu8s7k7oQnKi7iu3P/T8QXNfMFignFdMHj6v4tVyCsZNsDRs38BlwzyRE573J7wFV+vEGNrSiGZYkw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(5660300002)(54906003)(8676002)(8936002)(478600001)(66476007)(66556008)(316002)(66946007)(4326008)(41300700001)(6486002)(110136005)(36756003)(31696002)(86362001)(7416002)(38100700002)(2616005)(2906002)(6512007)(53546011)(83380400001)(26005)(6506007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFFPMzFwcU5keHhpTWU3WitPc3BRbExXQk9Rby9aZjREcTJXR0RZWlkzMUhS?=
 =?utf-8?B?dDFrTy9yWjZ0QWZienAyblJmUHVOOE5ZKytXUk1NSzJBSkp2aTZUQXAxbWla?=
 =?utf-8?B?ZFhhMFRDZEZOb1ZVaC9aNHNDUy9iOTl2NExJT0dQNkRMbG1peTN5MUVpcURk?=
 =?utf-8?B?bnE4THRud2ZSeXB4dzViaW9iNG1tL2p5Qnk5ZTZYVkYxZkJ2RERVbmwwKzh4?=
 =?utf-8?B?aE9vVUI3aWkrUzQvQ0xySG9YZitXT2NqQ2lCZlpjUG1Ja1dlcnRqd1JrRkhM?=
 =?utf-8?B?aFh2bjVaZDhuT1l3VHBHVnN6eDBqSnRNOFk1eGJ2VEtSb0pxTnc2dXhyQ0VC?=
 =?utf-8?B?YlhhcEprWE5ETVNBcnhhemdvMzJENjFHaFByQVFTQmVDc1VFdmYwVFJwUUE3?=
 =?utf-8?B?eE5PNDBOODFkWmhtemgrMmowME10LzhNdXM4NDRpOWtKUmI1dWVCMkRnTzJv?=
 =?utf-8?B?azBOOFRLS20xSnRVaXRMaHQwL05LQVQrbkpXR2c2em9MYlBONW1CdStoQWVW?=
 =?utf-8?B?L3JCN1pjUFJVSEJXUUkxVnV3WXU5YlFCeXRwakZIRWIxWjlaVXliWExyY0Qz?=
 =?utf-8?B?NWcvbVB0Ny90bGp1N1FpUHBpbVFXL3VOMzJZWjJEWkh2Y1J6VjF6TFhsSi9X?=
 =?utf-8?B?RG1CWDdrN2JCakE5emxxSVZjK0lRNTZwZlZSQmtrOEQvVnlKSjd3N0VDdnYr?=
 =?utf-8?B?ZHFjWkhkZW15dVd1azZ3OXFKZk1xNUtzRElibjFBUnJia2dkVFNteWFaYlkx?=
 =?utf-8?B?UjRROWIzQ09SWHF3Ni82dW9mODNNUVo1bERieUZrbmcveDNhQ0ZIM0ZtMkJJ?=
 =?utf-8?B?elpWN0JvbWs3T0JjZFdjL05YWm1LMHhDWXplOXRmUVU2T3JkREtXWVE1ZnJx?=
 =?utf-8?B?VndzdHpwQlNoTldkOVJtWkt0MkNSQTAxL0Z4Mkw2Tm96R0gzWG5ydEw2T3J4?=
 =?utf-8?B?QnZPUkt2cFEweEFaOW1XSitUZTFmMVdaUEU4c3V2bG40U00xMHFBbjE1dXNQ?=
 =?utf-8?B?M0VaUTZTeGwyVXBBS3Rnelg4dDNxK1BxT2NBSFpXQ3VKRUZ4R3VnSXozUHRw?=
 =?utf-8?B?YWt4ZW5YK0Q5Q3JsZ01JTTFIOFBVZmFBVmpPN0JwU3pXZHJISGxnKzdXQ1FS?=
 =?utf-8?B?UUhvdkloc1FGWXhGUnhSWFY2eWFlM1duZW5XUEsxbFBhV0JIc1JvSVZrM0wx?=
 =?utf-8?B?QlNCd1pyVVFjdGF4UmgvR002aXlhczRzaG1FQUxzeTZHWGUyK08rVjNLVnlo?=
 =?utf-8?B?cnVTVGk4MUx3MmZjbmc1MitXa2tlaTl0TUVwNGlYd2poUjZEWmh1VzY0S09D?=
 =?utf-8?B?OS91dXNjaDZDU1dkWHAzMXpiYmtsNEVYM1NkbEgybENwelAybEVqdTh3Uzd0?=
 =?utf-8?B?a1p2QVBrUmMxQnY5WEkvNkd1RFR6WnZIS0pQRVp2bGo5aWZaQXhxeWFrVzgv?=
 =?utf-8?B?RGJXSzg5VGRNcWxzWVRrSndtUXVFTEN5U3RVTkxVNEFZSFdzU2Y0UkZaR1I4?=
 =?utf-8?B?bmVvU2Mxc2tmWEx2KzgwTDYweWEwRHB5dXVIYVhpZmIrOWdOYy9odlBub1h3?=
 =?utf-8?B?TlBhcGp3d3VWcGRTT2p6U0I4ZjMzQkdHbkZFUFVlYmJxZ2NVUS9XdHpza1pu?=
 =?utf-8?B?RE91THlJdDM2VDk2cmI4L0d3UUJnYjdRdlVaVmVoTUZ0KzNHbE9Nb0Fra1BJ?=
 =?utf-8?B?ZHpBZWFMYmV4MGdwcFBzeDZZWVpZT1BCQ3NTREtoN1U1di9nZzlSUW1pYVJM?=
 =?utf-8?B?K1ZJWWNhSFZxLzNpU0VGaHlnRFRPWXpMeXh2UDFkOCs5Y2tCakZ6c0FiL1lP?=
 =?utf-8?B?ZFRyVEVqaTRKeElTSzdic0VJV2kzZW9keUV0bXRock5kYXpZWkpVY3Y2UGxX?=
 =?utf-8?B?d0N2NCtRRGkxZ1V1a1BmS0E4WXVsUklsaHNBbTZpSTk4ZEIxRGtac0ZXcFBV?=
 =?utf-8?B?ZHFzeEhwOXUrODRXZlh2dWNUU29pd0tuSWV1cTBsZHdGSEFBRHh6aVJqY1k2?=
 =?utf-8?B?UFhEU0QrSWpCMkkwQWZQdHB3MERtUFVJUEkyU1oxaUEwN2picVEyT0FvRFo2?=
 =?utf-8?B?SWF2Z21tRFJHZm00Ym1CNmlhdlNmdFVKd2RaWGpUWFBlUDA3K0RKQkdMaUth?=
 =?utf-8?Q?4qdtQQUuyA7qp6Rw1mHLUfhNu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6321d2c-42b4-4a2a-5652-08dbfff502c5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 18:13:18.5425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxrIjL9fmc9RCwetU7+j8yCn54kactRDtfF02so/57JGtuMqjOfNnKRTJs96JAkL0/exx55Mss7swuf9nQncQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8959

On 12/15/2023 3:26 PM, Ira Weiny wrote:
> BIOS can configure memory devices as firmware first.  This will send CXL
> events to the firmware instead of the OS.  The firmware can then send
> these events to the OS via UEFI.
> 
> UEFI v2.10 section N.2.14 defines a Common Platform Error Record (CPER)
> format for CXL Component Events.  The format is mostly the same as the
> CXL Common Event Record Format.  The difference is the use of a GUID in
> the Section Type rather than a UUID as part of the event itself.
> 
> Add EFI support to detect CXL CPER records and call a registered
> notifier with the event.  Enforce that only one notifier call can be
> registered at any time.
> 
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 

[snip]

> +	struct {
> +		u32 length;
> +		u64 validation_bits;
> +		struct cper_cxl_event_devid {
> +			u16 vendor_id;
> +			u16 device_id;
> +			u8 func_num;
> +			u8 device_num;
> +			u8 bus_num;
> +			u16 segment_num;
> +			u16 slot_num; /* bits 2:0 reserved */
> +			u8 reserved;
> +		} device_id __packed;
> +		struct cper_cxl_event_sn {
> +			u32 lower_dw;
> +			u32 upper_dw;
> +		} dev_serial_num __packed;
> +	} hdr __packed;
> +
> +	union cxl_event event;
> +} __packed;
> +

For some reason, prefixing the struct name with __packed attribute seems 
to do the job. ("__packed device_id" and "__packed dev_serial_num").

Thanks,
Smita

