Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DF24F536D
	for <lists+linux-efi@lfdr.de>; Wed,  6 Apr 2022 06:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbiDFEEn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 Apr 2022 00:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457635AbiDEQWx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 5 Apr 2022 12:22:53 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2058.outbound.protection.outlook.com [40.107.96.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2C86C90A;
        Tue,  5 Apr 2022 09:20:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjF6HRH6dR1+mHmBEq+V7t0DEgEtKGfjPaS7E8q4BGRjJVbtbUDqzovngEzJnsMXhXNUFx7kni0jxEySaigbMlE9LEASlwQ1okTDvNfqD2tsWP3aevS9qPVEaIxAtU4e2dsyZgKbMGgvIDC4vlg14yzdi3mFFDsp67gXkSotMUWfKY+BZqX9PmPiHGVf3vo5Yprw6seJ4czDFEVVnln6rNGukz+CWDtPwKqwU6t5Vri4V7iy9/E7l2hWbBepnjLbRrhnabaQui1D4RslbPoXaTzYzN8A3d/zhpNuBB5FnAYMR4f3uJ0UhL84XLH93vtrkA51fbgO5L/UTMBnmC1S2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynhe7eYng/QaKo7iCaJ2WaZ6r2eKliiiKTg3vJqk4gQ=;
 b=HPIcuCo43XaQebFEiNDLlfRA2xMJVm5uNYWlwgL0m4afw21BO6DJImmuKeBOedjLFR8XeEjQ4rDbzMY4/69CBiQ/wDmdXuCLjyLhXQNTzGBwai0nFw3zIYOPCBBPJECihBGcCmK4X/vxrrZbBbZlXyleUfRyiegfRUhRW01vNsvrqKF/obQbBUixX4MvjigSKFLkLaH6UC6dyKXfX9bj9SuMOR6phvfeFGIx8/1qDs/51OfC8T3lZHMeWmZhr0iVInjEFAmvesxGbTBc07l2YxbbtcmFl5H5GUjLr8FAXdoPYT3zTGSxG29KtGyac/BfQrudWs+oFpNc8Ud9T0ofiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynhe7eYng/QaKo7iCaJ2WaZ6r2eKliiiKTg3vJqk4gQ=;
 b=dZPfWal+xnw6NA35mh6puAgQL1Nuz3q6oeT5h8CFvYhZZbhv6CaYl65UPKm1GIz85VsB6tkyxaCfQFmcVDV27lNJkKN0PNwtkNq5kWudVdYRg4uU5AaJsiDSYdhDcyjOJJBYVqWyslmyjivVMurs72MuwR+tu8qYmzzhaE9ZaRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22)
 by CY4PR12MB1430.namprd12.prod.outlook.com (2603:10b6:903:3e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 16:20:51 +0000
Received: from SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::449d:764d:4b2a:1c1d]) by SN6PR12MB2718.namprd12.prod.outlook.com
 ([fe80::449d:764d:4b2a:1c1d%4]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 16:20:51 +0000
Message-ID: <f4369605-7c8d-1a89-bd0e-b82710d0772a@amd.com>
Date:   Tue, 5 Apr 2022 11:20:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
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
        brijesh.ksingh@gmail.com, tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v12 22/46] x86/sev: Use SEV-SNP AP creation to start
 secondary CPUs
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
 <20220307213356.2797205-23-brijesh.singh@amd.com>
 <YkuMTdckSgSB9M6f@google.com>
From:   Brijesh Singh <brijesh.singh@amd.com>
In-Reply-To: <YkuMTdckSgSB9M6f@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:208:32a::34) To SN6PR12MB2718.namprd12.prod.outlook.com
 (2603:10b6:805:6f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09c1fb79-b199-4e1a-5053-08da17204050
X-MS-TrafficTypeDiagnostic: CY4PR12MB1430:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB143026E8610656E369B39F68E5E49@CY4PR12MB1430.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CAAX8uVETB2lQP/KChQEbNPHR8boqlHQzZFoJMxq4ovmT7mFAjphKhp4tbIJw3nh1cIuYXKJilgr+7sqwNdw8YRfWJIT8g/S8C69t8ezHqrIIQOD86CkBbuLush3+GYIAwi4gmcMkD/N4qC7c2sev9Qhz+yM8ooTdOPPEK0QWwLFwaQyr3z7NlvYd8Xa56hhJ7FvAOV0IYEFEjZ+TsCbouvFfi19NkMnnj/PAJ9cUJV4/lAwUlphsCkUBBrXY0tZ+SpWtYESftoKJcdHjZYmsQe/oM/w6Kd6uigvzKTTUVtQOAeEKgl8FThpAfXu2NDa9shIMQd7Fj3Q697GgrQ73SUhFz+OuDtaF8Zsdf1TEV55JOoU/w8mGudK1PbLKWXpH/utzIcvXyg+OP6Zd+7EawWlrpJmKNI7TiklEyU8HDuHT9JXXfQ41dzpbC2YC1bK57IvIdUjc7ZjOtGlI8eGQ/5+4BvR703m2FL7oeYFKaerLzstaecjjNOyEg9kJAjL8qwMV0V/HTpdTd4azW9z0KoH8Eg0m6eaHG732tIe80WisxApi27mWptTqwkE+g7C8Bjj8vHLvNEdSmxC2J7CCtpNDy/mWvmVaGW55OWq/CbwvPqwgnb0BdsRWHpgCVRBViaIOKUHcwikL6PW9e6KzqImm0xilvvh0AAsL3laoxzYdD1cz6bPF6GcvIkPWInl8hThf055m4RvqvPqaaJe1PMb0armL22PbhvpMehZ6NDw20KbBF2tpqs+Z4/2Gb6+MZlXv5wvHApcbv80SvRLn02Ni2yTKfNgXanvWTEbJxo5ogetcfNbzlONZWlmhW3y0cAjGvDM0irNTN0MzNZ9FA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2718.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(508600001)(53546011)(6506007)(31686004)(86362001)(83380400001)(5660300002)(6916009)(966005)(8936002)(38100700002)(2616005)(54906003)(2906002)(36756003)(66946007)(45080400002)(7406005)(31696002)(66556008)(8676002)(316002)(26005)(66476007)(6512007)(6666004)(7416002)(4326008)(44832011)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXNMWFhjdXNNcS82V3l3QnBzTkkrMXUrMTlMYlRIY0k0ZU96OXFlcVhDSXdR?=
 =?utf-8?B?RFBCck55VGFSOWNPTzdBeHZZMTdFN3pvWGY5UHJxNWZFeGdzSkxXelBldG9W?=
 =?utf-8?B?cUp0S1Bla0owdGpGS3dTYkFqUEc2RUtuVmUvYWRneFJKbFBDSkpOd3Vkc2FT?=
 =?utf-8?B?amhwWnJXb2Jkd1pJSmlWR0RwcGR2cWswb3RjeDdVM0lEdm10bzBSSEdYeFN3?=
 =?utf-8?B?UnZmdEY5M2tnYkcrSFNyc082VUhXcEI5ZUZnbU51d3pTbkNJY1VORGIzZUc3?=
 =?utf-8?B?ZlJxbTdSYWpYUUtaNk1HUE9iL3ErR0o3ZHV4QWRtM1JBZENoWCt5cC9oaE1U?=
 =?utf-8?B?NGZSYWZUS25BWGpHWHFOZDVXVVlVV3BvNUZHem9GREl2YWJKaE1mbTF5Y0E4?=
 =?utf-8?B?S0pCV2NMV2hsWjJVWFJST24wTC8wTnZYUzYvY0NWVVg0YmNTWW8zNDBHckhK?=
 =?utf-8?B?RTY4OFZMSWdoQ3Vadk5uNlE5TE5rUjBMR1lzc3U5eDExNEJZOU9EL1RwU0FV?=
 =?utf-8?B?K3VuaEw2WW40VThFYTVVN0J5anNKQ0hLMmFSTXJiNCtxOE94MExBUWpHMGhx?=
 =?utf-8?B?N0dRS3pGRnlSU1hDL1FzMmdWQkZoSHdOSUlJVFJOZC9aRFp4bDlxNzRWZmlj?=
 =?utf-8?B?OHFhK3FqTGtqSkE2S0pOMDdvMEx0ZVB2aGpHSldnTmpzYWQ4WEt6Yy9uZzYv?=
 =?utf-8?B?Q1NPMld2MTNDalB0MEtuczVpZngraGppRzJFMitpVkVrekhhc1BDRjJvN0dG?=
 =?utf-8?B?WDNoY2pLQkQ1TnJUMVBiRURyazUvbFc3Q3lCQlhtOXhSa2JaYXVhVVA0QlY3?=
 =?utf-8?B?Y25QbHJTV1A4RmQyQkQzazNWc25TV01NQWJuOTdpZmtFR2FGOGhhaUd2cVRN?=
 =?utf-8?B?UEF2UmZTNytMVXZDaFdlWCt0eCtyWGhoYXJBRzdYOEdBREx5NmNhRG94alpZ?=
 =?utf-8?B?dzd0NytvVllaUjI1N29CdlZJTjdtdXUzb2JQclRpak00YVREaUY2TldwWWVa?=
 =?utf-8?B?MERTbFMxVzNjZ2pIRHFKR3czaWhnZ2JVZWNUQTdVajd2SHAyK0pjeXdOM0da?=
 =?utf-8?B?Mis1S3RRV0tFTFF5OXFCd2U5VjNDbGJOU0ZKQyt0TWM1L0ltdHpJdGQwOUtC?=
 =?utf-8?B?KzhIQmwxN3pScU1UQkovNzZRSGE4eHFtanVsbll4WWZWc2ZKbUJOU1BaWHd1?=
 =?utf-8?B?ZEh6aWFvSHR0M2tlUldpb2dEcUQ3d3IwVjFFZk1idlNwQVZYQ0svYW9JWkdS?=
 =?utf-8?B?aXpiZ1VuaW1MeHNUaEg4R0w0TFpKdnlYY2tBbUVKdzh3dWtUTmNQUXB1Y01P?=
 =?utf-8?B?Zkl4TE05dlJrZmlscDd5NEx0a0U5L0xnQUVjZDFRaDFaYVoyM1FIVlNwWDRi?=
 =?utf-8?B?dUVnbmxCWTJwZWQrZTVxdEdOOTRpckJlWjB0ZnhyZ3hCSHVLcVFucmlZMzVi?=
 =?utf-8?B?MmZuS3dsSkJtT0F6cWl3QzZjWmlMMXpQSHdWVlFZY3d6WUhtUHhkUStJVmZp?=
 =?utf-8?B?QXVKOWZ6eWI3MGFvWUxlWXh4NWg5Z3MzNGg3cTF5dmZxNzVXRDdhRURWL21B?=
 =?utf-8?B?S3VSZlB5MkorekFNd2RzbDVRbXI4NnlWZUt1OFAxNGsybEhiTkdYWTBUZDFW?=
 =?utf-8?B?YkhnQ0dmRk14eWVkS2pUZ05Gb1RoSm9hUkEwVVRrWnh3ZHhhRU9wNmkzS0Iw?=
 =?utf-8?B?VFlIbi9wS3VZbUJRQXA1SUR1NGFiS1hPVnNGbjJ6NTcybGl4VVpJcGZINnhl?=
 =?utf-8?B?eUZMdU0wb3F6anpNOHBoaERlVGljNHRLdzBheW5VTmQvRmxtL25lSmdzWC9M?=
 =?utf-8?B?eWRoVmNNUFdiZ3JmNksrNTRaYitvVWVjU2xvcTBXSUtVTGpYMDE5QUVJUmNW?=
 =?utf-8?B?WkNXQW9aNUpnWnR0UmdtUE1LQnFEeURYZWlOeUxEWmovWEdXbTZLeHU3NjI3?=
 =?utf-8?B?Y0RpOEI4OGw0dWt3N0RXc1Byai80bm1kRTRZTEQveGFCUEthZTF0OGlCL0JB?=
 =?utf-8?B?Vk9CTng5SDRuUU0xUTNUdzBkKzFXb3VCb0YrdFExZzVOcXZXcC95VHZtR0FF?=
 =?utf-8?B?cFRHMkVQbVBnUEZjMEU3RmgwQStaMnV5SXdxT3lmQUp0VXMrVVhEa2wxWnNn?=
 =?utf-8?B?SWljL29tSVduZmljUWhRcE0yakIvUHFBWW1YOHVBQXFCMkVTc0YyS2ZEMjY0?=
 =?utf-8?B?UG1QVWhXYWN3Q1JBWlVmbGc3OGg1WmdGMzM5NHh0N2I3MHVSVlI3WG80VjJt?=
 =?utf-8?B?aFdjSzdGcjZTNkFxMVNEMFdyWVlwT2d5d3BKeFRxVUh6K3ZrSzBDQkhoaEJK?=
 =?utf-8?B?QWhGUU1NUzJIZVduTDVUbEMrbFFnVjlzRjgwQ2VJY1RUZkVEWmNJZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09c1fb79-b199-4e1a-5053-08da17204050
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2718.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 16:20:51.5962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JK3puR3O15EGO5WEkML2+HHtM6TMvZ0SovL8tHMKMk009J4Ia2CheeD4h2bndRsvE5o7GzIUy5nfWUDx8DRo6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1430
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Sean,

On 4/4/22 19:24, Sean Christopherson wrote:

>> +static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
>> +{
>> +	int err;
>> +
>> +	err = snp_set_vmsa(vmsa, false);
> 
> Uh, so what happens if a malicious guest does RMPADJUST to convert a VMSA page
> back to a "normal" page while the host is trying to VMRUN that VMSA?  Does VMRUN
> fault?

When SEV-SNP is enabled, the VMRUN instruction performs an additional 
security checks on various memory pages. In the case of VMSA page, 
hardware enforce that page is marked as "VMSA" in the RMP table. If not, 
  VMRUN will fail with VMEXIT_INVALID.

After the VMRUN is successful, the VMSA page is marked IN_USE by the 
hardware, any attempt to modify the RMP entries will result in 
FAIL_INUSE error. The IN_USE marking is automatically cleared by the 
hardware after the #VMEXIT.

Please see the APM vol2 section 15.36.12 for additional information.

> 
> Can Linux refuse to support this madness and instead require the ACPI MP wakeup
> protocol being proposed/implemented for TDX?  That would allow KVM to have at

My two cents

In the current architecture, the HV track VMSAs by their SPA and guest 
controls when they are runnable. It provides flexibility to the guest, 
which can add and remove the VMSA. This flexibility may come in handy to 
support the kexec and reboot use cases. The current approach does not 
depend on ACPI; it will also come in handy to support microvm 
(minimalist machine type without PCI nor ACPI support).


> least a chance of refusing to support AP "creation", which IMO is a CVE or three
> waiting to happen.  From a KVM perspective, I don't ever want to be running a
> guest-defined VMSA.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2FYWnbfCet84Vup6q9%40google.com&amp;data=04%7C01%7Cbrijesh.singh%40amd.com%7Ce6a0199ed3344529241208da169ab52b%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637847150997306218%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=w1eo3vza4Txv6tcgB6aO1rCoYOygQvGwKZ1kajgCbpY%3D&amp;reserved=0
> 
>> +	if (err)
>> +		pr_err("clear VMSA page failed (%u), leaking page\n", err);
>> +	else
>> +		free_page((unsigned long)vmsa);
> 
