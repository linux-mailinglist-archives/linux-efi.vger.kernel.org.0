Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731E65A192F
	for <lists+linux-efi@lfdr.de>; Thu, 25 Aug 2022 20:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243587AbiHYSyg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Aug 2022 14:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243546AbiHYSye (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 25 Aug 2022 14:54:34 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D9AB600D;
        Thu, 25 Aug 2022 11:54:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uy8s61Kx8jXB3D4jYeuk+3wkNZh0jozmNo/ca3oa59ZfLbcmQwr91B4IGZVFYr2V69De5V+Lo/3n8XRT8u4Bmm395gsfp1iApM/JaVSNUm4hvJvjVShNN2YTsN0Xlk9OjVIfQO/O6jeNO16chCkb1OmYHkHOZDkZdTtI4azQvAuD9n3NhRLJaeD/fefFICsFEoo0EyQe3ZompPnF3DCS6ikWRMQM2lYqrUO8BGXPCadcmfjNOudDZy9FiOjXyr4rrAmIcTfmQ9PX3ih4/BZkBKpP/EhMlOPdm1ifELpQ8tZTZf7prFa2Fi27LxUiPx+SqbtNgVqtZXa9l8bfL1aMXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDqf3BZ8ibbAPiKX9oOdFOG0P14Pgbu62x2xGtd7Yx0=;
 b=g8yxz8n+ckisaUfUt1bXq1AcbaoHaftdX2/JwxUUHUWm2fJbvWWo3PfuP49ggCFAjXK9n/VgukgyRq3amOOKp2Qm5DEwRlgll1GzpWcQcj1G7aJ3NX7ibAMKhMJAxQNrBmVS2YH5pcYdGDetyX7lbHg5eM2H+m3OuM83ygoV3a8DLz2UmwBf3lnadjMioGJ2aQdtsynOlTZPfklsETA17yRGjNxdthqnpY737tl8pMTrLqptAOZoHElbxOCB7jCLF7z+QAwLtMzZCIvcfhnzB8TK/HWFD6+MydoC8nvsrHuHrueFI0I8TrOFompWXNMBZ07EtXBKacuN0jTEB26H1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDqf3BZ8ibbAPiKX9oOdFOG0P14Pgbu62x2xGtd7Yx0=;
 b=cTz7ODzF4tXNSlpjOdce/OfBnkKt5cOyZSXO3SSjPaESlqpdV/LU0Q9f4+1El/TOK1jZhfGbjbkmm4hsMESyUrOJMqQz+eW9OrceiIT7Kh8tr48nI6oq8j+ooAcelpSvYi2yieEh2F3oVi6PdMIQjmCN8r5aHKWkoIzDiOGw24E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12)
 by BYAPR12MB4742.namprd12.prod.outlook.com (2603:10b6:a03:9f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Thu, 25 Aug
 2022 18:54:29 +0000
Received: from DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396]) by DM4PR12MB5229.namprd12.prod.outlook.com
 ([fe80::c175:4c:c0d:1396%4]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 18:54:29 +0000
Message-ID: <51298b17-9e12-7a08-7322-594deac52f53@amd.com>
Date:   Thu, 25 Aug 2022 13:54:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v12 43/46] virt: Add SEV-SNP guest driver
Content-Language: en-US
To:     Peter Gonda <pgonda@google.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:X86 KVM CPUs" <kvm@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-coco@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        brijesh.ksingh@gmail.com, Tony Luck <tony.luck@intel.com>,
        Marc Orr <marcorr@google.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
 <20220307213356.2797205-44-brijesh.singh@amd.com>
 <CAAH4kHYm1BhjJXUMH12kzR0Xun=fUTj-3Hy6At0XR_09Bf0Ccw@mail.gmail.com>
 <CAMkAt6oKQ3CnmNdrJLMWreExkN56t9vs=B883_JD+HtiNYw9HA@mail.gmail.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CAMkAt6oKQ3CnmNdrJLMWreExkN56t9vs=B883_JD+HtiNYw9HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0249.namprd03.prod.outlook.com
 (2603:10b6:610:e5::14) To DM4PR12MB5229.namprd12.prod.outlook.com
 (2603:10b6:5:398::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8e91f02-b9d5-49b5-091e-08da86cb3d70
X-MS-TrafficTypeDiagnostic: BYAPR12MB4742:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q4RvBjkxWnZMvJ2Xbr828CTXQtZZDPkqqcmT1YjeolgaTSo19ILJ981MeuY+t3XNfk53qv8yNPxnLgKQ/FoJkW/qBctiuZ8Zp9+wMt5I+uDMrL9R7vNTrB0FvrXi0tjOTkkeHHLMAo9xI9/Cw3F3Afv8YvGCrwUKCpS8GRQAmDOzWPn29sMgBwvt6ZaEXE2SB8v26HIRqoIG0vN3JIvxxhBSuDd6upFrSI+eUR1u1fx75xt8PXRJJOdtFW9LyzOrpuMR3T8ezxXhhIiR1hjSNCBndShMMeL/SiPz6uYIzk2xxU2nH+go7d1UzfgPnqR9+rN5o++URfkInX+WW/jYwuEEidcRYc45E1cKkYKzYAENsb7khmDKI0UEiRxCeIuCAMMTGGEtNLmVIN3rhIRY1MvfZWbka/4yPyiaXi8ck0eQVkeml1HequR1/ZxQqbUoNSykmpYsMEbVPVAhemwIvxOFAq88+tQAjgy1hBBS+G32vwenRJLSfoGcTLpxGd0wTN820tC93wibvGts3ys2d3izcC+khjdEfG4kjGXvrv5+SvuhQj9mUH3Ib+cjoD+lhUJuuiCTF0kmuhHSzn8O2GhwVsgNHiXbTOf6AxHkhedQBajGkXYSqP1OJcwPRz0lDznoPGRH/E8Pyw4O0ZMRI+DSO26U1b2WoWM5zLZD+gG0FwI0cAh2OsCiFKv0M0rOP034kCFZrctE4ZX8SNkFN3tMnPsqsQ7gDz0puM4/WhzaMFy+s94Lv5H5LEgdJmZ8ELwoX8m80Rd7ZE7ui9BSczEMWR4PmGqaWUQawkNleiA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5229.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(54906003)(66946007)(66556008)(110136005)(6486002)(316002)(66476007)(31686004)(4326008)(8936002)(8676002)(5660300002)(41300700001)(7406005)(7416002)(478600001)(36756003)(6666004)(186003)(53546011)(6506007)(2616005)(83380400001)(6512007)(26005)(2906002)(38100700002)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGpJdW5qL2RKTnlQbytnblA3TDVVREhQYmRJT1ZFalhuZ0V4SVhQYkp1ZmU2?=
 =?utf-8?B?aThFclZpYU1pZXJqQ2pWbS9BajdHZUVoOUdYQjRkMDJBTHk3U3ZLZXJJSkRn?=
 =?utf-8?B?WGg4M09aZngySkJNWnpnMEtpVTF0UUZoY3VUZWUyL3hoU1pZZGhwTkFod3ZV?=
 =?utf-8?B?Rk5FWFU3MnRhM1B3QzVqNldhYTFuaDVaU3VVaWt5UHBBTDRBbkg2aGI2Y0dM?=
 =?utf-8?B?ZHhDVWxrNzBZQllwNWlpYnd2cVVpdi9HQVBjQkQydDl1QnNkT0p6SVhVdmlw?=
 =?utf-8?B?YXlJR3V5OVFTTkN4S016RTh1NGppM094VXM4WWx5aVYxY3NPZGZJWGF5Zmcv?=
 =?utf-8?B?ZUJvNDdqQUkySTQ3L3VDYWIzN005YUE5RVQ2bVJZZHpVTkt3c3doL0s2SWdV?=
 =?utf-8?B?T3A0MWM0L0RULzhPakFvZ0FWQW1Hd2lwSWF1TGMxdzBMM1hvT0xFOUd3eHlq?=
 =?utf-8?B?Zmh5VHk2dUZTaC9RSUs4Z242UTQrQ0NhZGZLTExWMWtZSWFJYTBGbUlBNlhx?=
 =?utf-8?B?MWdLdExYZStDVEVhYU5KRld1dmQ2ckpIUTJQa01EV3NiL0pnVVhVaWVKUHQ2?=
 =?utf-8?B?bjZYZXBlblVwdVhkQ0M5RXRDTEJ4L3FUanBEV294RFhDZXR4a2JyMms1SDlZ?=
 =?utf-8?B?YTFXdnQvMGNzZjNmR2lXK2daSWRiRmtFLzl4M0MrWmpDOFNzaXNFa3hJTWQv?=
 =?utf-8?B?RFo0clFUVU9tM2RFMzFuMU1jakV2dWdJNmtYM0c5bStDVkRWVXdKQTdGRDBr?=
 =?utf-8?B?aHJ0cHVNTGpLeXJSeEZvcWRaak5EUmRwSDczcVhqaFJBcEJ4eE4vbnBGUTFN?=
 =?utf-8?B?aHdESEVKU0Y4a0hJdjFxQk1WNm1wT2N2ejhHWDczWjRieksvSTJyUFlIT0lK?=
 =?utf-8?B?YkVHSm56eko5cmdmRC9QM2dwazFEaU9xN1dvT1VaYlpBM1NrQlZZZXJEK0o0?=
 =?utf-8?B?NWdIS0xFNWwxWVpDcFRjSzc3QTVZbjVYM0RldkxWUCt3RDRSRlo2REExdHB0?=
 =?utf-8?B?UEtPaWp1aU5pYk5oS3EwVkdXNTdQRTh3L01FWkJpTnZmSW5xNGdwcTJRdUVt?=
 =?utf-8?B?QzkxTTdzajF4VkYzSnN3RmdMZHNIZkNmb1Z0d0tkdWx1cWk2TGE2QXFvSTlB?=
 =?utf-8?B?RzFsc3RYME1mWE1GVXZNZExBUStheXEwSjRCa1Z4dXhLdWlkdi9ONlhVQzBv?=
 =?utf-8?B?RXpJWUt6aHQ3a0tRSVlzeUx4ZVZRZmZiaDBQUUxsTWlFcDAwMnRmcVdQK25H?=
 =?utf-8?B?Mm9SR0JqcVlKemQrTHlOd0RlK1NqQ3FNaGg5eDB1MUZhN09LbHExOWZ1cGh4?=
 =?utf-8?B?NDFEckNtZVdFWGJIeFFSdkxpbW5WZ1J3bVlvVjFDTTFLV1psbnlWV05TZUh4?=
 =?utf-8?B?TjhqMis5THNnWTdwL21MMUIxejgxeFpqRnlWZ1dJRkVsV0tHOHYwUVMwNElP?=
 =?utf-8?B?b1pocUs1MjdjcEFrZlQ1L04zazNVVmZIcTA4bDYwdWdTVlM4amhNT0dQYjUz?=
 =?utf-8?B?RzdZSGdJM1NrQTdUakVaYmlhWXNINlBXMCthTkVPeVFsVFZETEhnZWdtRElq?=
 =?utf-8?B?YVE4UHJYam1zcVdQRnAyZS8xTUtaNGtRUENCdXkrdjFHeFd2bElvVW1EZnVT?=
 =?utf-8?B?dWlxM1JVVnpqeXV0bzFmWFRvV0t6NnRLbWJXQVNZOHhZNUJyZW1jb3h3Tlla?=
 =?utf-8?B?VkkxOTNib0lQT1NwSUd5Y2hicTBsOEVwY0FzSEh1YzRmSmR0TkpvOWt5dXdQ?=
 =?utf-8?B?bWFZMzB6b0pmVzFNK0ZHV3c3c1FjOEpIVEdLQmpyb0xhZW8vV1NPZzBFakx1?=
 =?utf-8?B?OE80RUd1Z0NEdm4zWXdqSHBiZGE4RW9ZYkNzRHNjR2ptaENNWEw0U1Z1Y0JT?=
 =?utf-8?B?S3FzZC9UL0NDKzV4U0tUc1d1azkvRE9VU1BmQ3F2T21SeksyMC9TM0FkTEdx?=
 =?utf-8?B?STZZbmhXN2UvKzhaMG1FM093MDE0ZU1yUGp0NStCSStFb0VvTHB6dlA5cHdM?=
 =?utf-8?B?bGYwSmRkUlRoYW1WYUtGMFExZ3pvaDlvcTYvWmxDNnZaNzArUmU5Tmw3aHc3?=
 =?utf-8?B?cXdFN3dRNlZBOHIvZk9hbU5rVEtscCt1aTB4ODJ3NDBVczkrWUhkMnU1WVRN?=
 =?utf-8?Q?8yWnSbNT+YbtzkeVaiAD70a6y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e91f02-b9d5-49b5-091e-08da86cb3d70
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5229.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 18:54:29.6394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+NV2oIV8ktVImJn3Np3WMHm8EdDNkrbjlS9OBfn2svKwaFrz/VaGUW4LaTtI2foqYwGa/GJAd2humZG2Jmfkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4742
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 8/24/22 14:28, Peter Gonda wrote:
> On Wed, Aug 24, 2022 at 12:01 PM Dionna Amalie Glaze
> <dionnaglaze@google.com> wrote:
>>
>> Apologies for the necropost, but I noticed strange behavior testing my
>> own Golang-based wrapper around the /dev/sev-guest driver.
>>
>>> +
>>> +static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
>>> +                               u8 type, void *req_buf, size_t req_sz, void *resp_buf,
>>> +                               u32 resp_sz, __u64 *fw_err)
>>> +{
>>> +       unsigned long err;
>>> +       u64 seqno;
>>> +       int rc;
>>> +
>>> +       /* Get message sequence and verify that its a non-zero */
>>> +       seqno = snp_get_msg_seqno(snp_dev);
>>> +       if (!seqno)
>>> +               return -EIO;
>>> +
>>> +       memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
>>> +
>>> +       /* Encrypt the userspace provided payload */
>>> +       rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
>>> +       if (rc)
>>> +               return rc;
>>> +
>>> +       /* Call firmware to process the request */
>>> +       rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
>>> +       if (fw_err)
>>> +               *fw_err = err;
>>> +
>>> +       if (rc)
>>> +               return rc;
>>> +
>>
>> The fw_err is written back regardless of rc, so since err is
>> uninitialized, you can end up with garbage written back. I've worked
>> around this by only caring about fw_err when the result is -EIO, but
>> thought that I should bring this up.
> 
> I also noticed that we use a u64 in snp_guest_request_ioctl.fw_err and
> u32 in sev_issue_cmd.error when these should be errors from the
> sev_ret_code enum IIUC.

The reason for the u64 is that the Extended Guest Request can return a 
firmware error or a hypervisor error. To distinguish between the two, a 
firmware error is contained in the lower 32-bits, while a hypervisor error 
is contained in the upper 32-bits (e.g. when not enough contiguous pages 
of memory have been supplied).

Thanks,
Tom

> 
> We can fix snp_issue_guest_request() to set |fw_err| to zero when it
> returns 0 but what should we return to userspace if we encounter an
> error that prevents the FW from even being called? In ` crypto: ccp -
> Ensure psp_ret is always init'd in __sev_platform_init_locked()` we
> set the return to -1 so we could continue that convection here and
> better codify it in the sev_ret_code enum.
> 
>>
>> --
>> -Dionna Glaze, PhD (she/her)
