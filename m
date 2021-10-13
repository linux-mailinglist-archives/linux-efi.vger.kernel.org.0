Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71D442BF09
	for <lists+linux-efi@lfdr.de>; Wed, 13 Oct 2021 13:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhJMLjZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Oct 2021 07:39:25 -0400
Received: from mail-dm6nam10on2064.outbound.protection.outlook.com ([40.107.93.64]:31200
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231208AbhJMLjY (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 13 Oct 2021 07:39:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MByG3BaFlxiqinJ69cItnYaQUlb0Sxgg98YMx+j8lucvTl43MdS/O3fjlBrQmOdOkfpUZFpffHr753YD6LMcqzqFa8LnGmaEGDU7ZeSb1jfAFq00NiMTnOS9OZznupGQfK+EQer9l4iuS1QYLdWVMVIfWkmUesnBOW5TDEXf1E4+wzw1DYVMVFwGHySw+s4yYObCL7CRmPekHHD0CtJQyp7RUHYuMnhfiAO5/klOf3LvU1kxx9Ka3/srpPQXCNBs691Wog7alkEx0ebg6IlPmtLBzmGL8FfjWn+7k/IUYdVXAVVPF/Xxgxz8/rH00lb0OQ452oijTzyg/KRwynQGsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o72d6f9MtTST+DT7w4aH3pv4TTM9Qgt9DsVlI5dGPxI=;
 b=hs8Bj43UZ/K5gD9DmjfvWUD2swn6tjL2JpGIaMH8ZqG5WkNVBO5y2YcO1q4WNz+7ZWn9lgGo5RGuQEwhDsG5V1WltXofiiGgVjPNvpsPX/U9ptnmtRBEDBYBkY3ic6T1Pa5CEatnkfE4+OMakSxHHT1E2Ln5nPdA7cjSkiFbuhAxlEMPY6n1gzIsxCMYvrL6GMZQqrR172cS7V32YcmKyadzSOjUpZbipp2xW5W20cirPqVYldTqCFtV+yks/J1PrX7skzqex58CFrkhAdSoX5ANcZRGIvory1dnz67TapyCpKjG0d9HXgp1GqB3ZB/aDeBVYIq3dhd593qkaA3jXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o72d6f9MtTST+DT7w4aH3pv4TTM9Qgt9DsVlI5dGPxI=;
 b=TtnaLjiV7vuMcjdqHOictik3WC2Ev5iplklGMmYW4lEEkRwSU51OehmZMbP53lQHsK8/IEfzKz7fmhalmrNKJta7maoj9s8u/3cIi519FX3Q6K6PAnWVmdVD/FK+CUqW7Tz7UenwAhaEPY6dmexGPoPQErFHdWl2RWnXRS+XOhg=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by SA0PR12MB4559.namprd12.prod.outlook.com (2603:10b6:806:9e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Wed, 13 Oct
 2021 11:37:17 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::78b7:7336:d363:9be3%6]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 11:37:17 +0000
Cc:     brijesh.singh@amd.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v6 40/42] virt: Add SEV-SNP guest driver
To:     Dov Murik <dovmurik@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
References: <20211008180453.462291-1-brijesh.singh@amd.com>
 <20211008180453.462291-41-brijesh.singh@amd.com>
 <b79cfdfa-6482-70ab-3520-f76387fe4c27@linux.ibm.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <ecf55de1-94c7-4f86-2578-141d6dfbe348@amd.com>
Date:   Wed, 13 Oct 2021 06:37:12 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <b79cfdfa-6482-70ab-3520-f76387fe4c27@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: SA0PR11CA0128.namprd11.prod.outlook.com
 (2603:10b6:806:131::13) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
Received: from Brijeshs-MacBook-Pro.local (165.204.77.11) by SA0PR11CA0128.namprd11.prod.outlook.com (2603:10b6:806:131::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Wed, 13 Oct 2021 11:37:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0205290e-619f-41cd-bcc9-08d98e3dcf0b
X-MS-TrafficTypeDiagnostic: SA0PR12MB4559:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB45592AE1EA82E36545DA944FE5B79@SA0PR12MB4559.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qvDn56x2zCGqTLm8hnpJ31WVNCyL2zske6UEL+II7gS69RCqk1Sv37cWPeJ89IdQ6N5Yh/HxtTjkW2HoKhkua/buwM9PbloXOHRN15HHivRpw/gQjEeQ3XXdsdlemypFFMTjtpWdX0lpYuhXN3ewjKLD93n8sscqIPrsICMhcgb8ewLKdSpoYbJ4A7pCTkzQHKBH3QzWBkFSdM3+JRzhEMoTy8FrR4KTUwVF+QvaJ+yJmJavOjRTfa1pjMDBVzkuQaZRVrdK6rewIDsh0+VqPOgf7+SCPvygIXB7SczupIWUQ4VK5YBYsJgvrhnrvijEz07sBzLtmUMTasF5VYajSUaD72uEDJ/uQBClJ1Po1WD7cXkihJrrNhqzkXutnGQgBICxtgJLiu1CCrTQ6p9l4rhobDpbJSM72mzimhCNEnukTr4yji8kdOq8thhao1FdwNHLOOdXkXQ2REWLLSXDHc45jvfXFkPa4A8nBG9Rq+mi6hzjvGtkVul/ECioQiXUHKYV9VeT9CuW46FIDZPJQTAAv8SXmYVuT5frmRyGKAa1E/Lzi8alegErxoeHNRZqO6HDgdXXCI6RJfPHowjNpa4inVW5qmVhcpS0p8iEQs/hzCpL4Rg2FjRX7SuEv0Yy34JKLvkCZpV97I7/dc+BPIi9zlyd+aldE7Fo/e8h3e3X9pRKcnAB6xdFOFg6tfeRK5p+29D+DEZ6ooL1CZTmuoJoHoP4ceyvBLu1N8B9uHs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(5660300002)(83380400001)(8676002)(31696002)(54906003)(6512007)(8936002)(86362001)(2616005)(36756003)(26005)(316002)(66556008)(53546011)(6486002)(7406005)(44832011)(31686004)(2906002)(6506007)(66476007)(38100700002)(66946007)(508600001)(186003)(7416002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEZKbUlnU2xIdFRRRG96VGtTbExlbFl6TC9abVE3a3lCM3dtVnhHS3pxSms1?=
 =?utf-8?B?N0JBczVudlJ0bys3aWFqaGVieVM4QncyTlBRWjRUT24yNnMwVEdUc3k1MWZy?=
 =?utf-8?B?RUxmejl6VmtmWURZS0R0dFY0ZTNxTEdDa21ra2dMSVJBNTlUMGF4YXRDcnlw?=
 =?utf-8?B?cFN4dzFOeVRSUTkvS1g3U1hpQ2VNZ29OblVzckdkMTlkelNHOHZoNzM4WEtR?=
 =?utf-8?B?ZC92bGIrcmJyaUU2OWxjZ1ptZWFCSk5peG4xQjc2VFRqUWJqNFVoMXNXdTdT?=
 =?utf-8?B?YnJCL3FqMkExL2VDNWk5ZG1wVVlSUmJIeFdhTzdwTU0yT0dyQVlLM0V1T1Ri?=
 =?utf-8?B?MG5BeklDTEovTzhpdEpoU2E3dE5zM0JTT2R1NUFvbkVneldnWDFZQzRoUW9R?=
 =?utf-8?B?Rmlld2xYUnZGRHFnNkVHWUZhVGpzWEU1NUlpRWYxT0swNlNQczcrdjhrTGNL?=
 =?utf-8?B?R1NmTCtHd3RIT2tzTTNzSGk3dERKZmFJRVhKNTlwSDBDVHNoaUQ5dXowbXQ1?=
 =?utf-8?B?a1hjeEtBRFJ4bXM3SVVtTmxqYnlsaEZHMWJ6dkhVZjIrUmhFMGM2WE1FbEpj?=
 =?utf-8?B?MGxpcHl6MmhydWoyUm1KR09obUo2anZzeHRWM29NcCtGVk4yL01nRmRLbHZv?=
 =?utf-8?B?dTdKSkhFQTlsODhadkJnM2FLWWx4dk03TU1QK3RGL1VPeklSU2ZJd0IvTFlW?=
 =?utf-8?B?a0lBd0M3R2RxMXk3aTBMdExkcURwQTEvbzhqSFlpNW9IUm5jRUVvRlVOK1Rs?=
 =?utf-8?B?SnB4dFZpcXlxUWExWlhJS2c5Vk5tK2drOUdOTkhHd3RqYzV6VzZ1amdLdnFW?=
 =?utf-8?B?aDNOOWt4L3RTNUQ1S1UyQm9XZ28yMHVaekFOU3NibmhBZ25EZVVHNitVWlFQ?=
 =?utf-8?B?a0E1N3BKN2cvNzRwVmt2TW9YQmtWQzJxajNMdjkwRVF6OEhqTWQxaFU3UEMz?=
 =?utf-8?B?cDRoK3EwaGFkdENmbEF1ODZIMXQwd3pJY3hzSTRXRTh1OUdKZ1hzUTR6QWhm?=
 =?utf-8?B?QUZheTZlVXc1bk95WGV0bWcya0k4eFpzcnQvdmZqT0I0N2g2Q1ZzeWtVaTh6?=
 =?utf-8?B?MHFSbjFkTzFIdTIxM2g1SThZTEtEYTNVYmRubm53K3J5d0tjMG1WY3VzMWQ2?=
 =?utf-8?B?b1ZibGY1NXJWTHpqdzRrUG1PMm01M3E4T1VNckhhTmVvWFFnZFhRWERhNERT?=
 =?utf-8?B?dDlESklJVFJhVGUyd1g1TG5sdHRORVdLdjVxcURTdmxaTUM4RDV3eXFFcnlk?=
 =?utf-8?B?VEJkVWg4VEZqY2Nsc3A3RGw1ZkxOdVJLajdwTmVzUlpqNm5iVEdkTTBuM2VF?=
 =?utf-8?B?NDNYVFhEbzV2aU9MOEFhL2g2WHppRWhMaVNZd1dWSGZZdXhNQ0JaMGJzMnpo?=
 =?utf-8?B?bXlaS0lWRWNDa2xxa0dVYWYzWXRaUWI5ZjRBR0pKRXBIMTVuc2pxUy93WWZR?=
 =?utf-8?B?dzBHSUJxVmRscjhSSzArTVRQOVBJYVFYaDVUcGkybStyRnM3R3RvUUZkcmFE?=
 =?utf-8?B?M0JUS2hyRWdUWjNwNlZvenZmVjVhMW0wd2lRL0JuOGwyamlCRkdERDNlYkwr?=
 =?utf-8?B?MmVIa2s1ZjAzMERHeDZnaHhVK1lNVFZJTnhKNUR3aDdPRE9ic1JReWxXNSt4?=
 =?utf-8?B?VlJiUjZnK3dEU0xDbjl2Y1VhY1NyRUVEZ04zcDR6bmNqYXU5SWNGRk1TYnkx?=
 =?utf-8?B?bUxZZmpHS2RSTVIxYU5kbXVYaFJETEhUQmlKY3N6d0FMWFdCRFBobm5JQUpN?=
 =?utf-8?Q?QeKx4+c63bjbBIo6PybfREWA2nC7KXUOdi5S4Ov?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0205290e-619f-41cd-bcc9-08d98e3dcf0b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 11:37:16.9926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tMsVDuUPOlElvKn8Yf+Y4P8bNgKFV+sobDAmunNfeWPqmnR/DiPQEGCjzNI5GDeI4Ws0AMO3/7yLV3v+u17TBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4559
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Dov,

On 10/10/21 10:51 AM, Dov Murik wrote:
> Hi Brijesh,
>
> On 08/10/2021 21:04, Brijesh Singh wrote:
>> SEV-SNP specification provides the guest a mechanisum to communicate with
>> the PSP without risk from a malicious hypervisor who wishes to read, alter,
>> drop or replay the messages sent. The driver uses snp_issue_guest_request()
>> to issue GHCB SNP_GUEST_REQUEST or SNP_EXT_GUEST_REQUEST NAE events to
>> submit the request to PSP.
>>
>> The PSP requires that all communication should be encrypted using key
>> specified through the platform_data.
>>
>> The userspace can use SNP_GET_REPORT ioctl() to query the guest
>> attestation report.
>>
>> See SEV-SNP spec section Guest Messages for more details.
>>
>> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
>> ---
>>  Documentation/virt/coco/sevguest.rst  |  77 ++++
>>  drivers/virt/Kconfig                  |   3 +
>>  drivers/virt/Makefile                 |   1 +
>>  drivers/virt/coco/sevguest/Kconfig    |   9 +
>>  drivers/virt/coco/sevguest/Makefile   |   2 +
>>  drivers/virt/coco/sevguest/sevguest.c | 561 ++++++++++++++++++++++++++
>>  drivers/virt/coco/sevguest/sevguest.h |  98 +++++
>>  include/uapi/linux/sev-guest.h        |  44 ++
>>  8 files changed, 795 insertions(+)
>>  create mode 100644 Documentation/virt/coco/sevguest.rst
>>  create mode 100644 drivers/virt/coco/sevguest/Kconfig
>>  create mode 100644 drivers/virt/coco/sevguest/Makefile
>>  create mode 100644 drivers/virt/coco/sevguest/sevguest.c
>>  create mode 100644 drivers/virt/coco/sevguest/sevguest.h
>>  create mode 100644 include/uapi/linux/sev-guest.h
>>
> [...]
>
>
>> +
>> +static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno)
>> +{
>> +	u8 *key = NULL;
>> +
>> +	switch (id) {
>> +	case 0:
>> +		*seqno = &layout->os_area.msg_seqno_0;
>> +		key = layout->vmpck0;
>> +		break;
>> +	case 1:
>> +		*seqno = &layout->os_area.msg_seqno_1;
>> +		key = layout->vmpck1;
>> +		break;
>> +	case 2:
>> +		*seqno = &layout->os_area.msg_seqno_2;
>> +		key = layout->vmpck2;
>> +		break;
>> +	case 3:
>> +		*seqno = &layout->os_area.msg_seqno_3;
>> +		key = layout->vmpck3;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return NULL;
> This should be 'return key', right?


Yes, I did caught that during my testing and the hunk to fix it is in
42/42. I missed merging the hunk in this patch and will take care in
next rev. thanks


