Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 114C25774AD
	for <lists+linux-efi@lfdr.de>; Sun, 17 Jul 2022 07:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbiGQFbx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 17 Jul 2022 01:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGQFbx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 17 Jul 2022 01:31:53 -0400
X-Greylist: delayed 921 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 16 Jul 2022 22:31:52 PDT
Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E2B22285;
        Sat, 16 Jul 2022 22:31:52 -0700 (PDT)
Received: from [IPv6:::1] ([IPv6:2601:646:8600:40c1:ae5e:3057:2e2c:7f5b])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.15.2) with ESMTPSA id 26H5FeWZ725281
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sat, 16 Jul 2022 22:15:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 26H5FeWZ725281
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022070501; t=1658034943;
        bh=2oBoSTWNfbYjfQp5I53ct47lO8uP5kHvPPZlw0O0iT4=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=x9NX+33NijYF6F4JSe2y1tPLDO3Vv0GKcb2L66yq+xscfClCQYR3I0FKpfj+dnHXH
         d7BHMb3RN1f+jpj5lZyLsoxAvENnGI+BDriJ+MekMAcKOf8oXYP1/DI2qZrnXiAx/Z
         1rKyWVEzlND39q2MTT55L2fCG4Xgvvnuglu7tQmZQMuieim0Ipe+aGD3a+ItWQdWeI
         z74RwIF3MX13sn9vkrl54IpGsQMq5Tzpwm9MsMLf1vYfqUDpx7xFiNEB+gftJHYS31
         YIb/nb6phxefYclwPAukUrvcU4CzYiEdYMrl8b7K7w9pi6jthuuMt5zEeWk9DaBXCv
         EfPsfdx3helig==
Date:   Sat, 16 Jul 2022 22:08:09 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Brijesh Singh <brijesh.singh@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org
CC:     brijesh.singh@amd.com, Ingo Molnar <mingo@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v12_29/46=5D_x86/boot=3A_Add_Co?= =?US-ASCII?Q?nfidential_Computing_type_to_setup=5Fdata?=
User-Agent: K-9 Mail for Android
In-Reply-To: <91ed3c18-6cff-c6d4-a628-81f1f71b21dc@amd.com>
References: <20220307213356.2797205-1-brijesh.singh@amd.com> <20220307213356.2797205-30-brijesh.singh@amd.com> <87v8vlzz8x.ffs@tglx> <91ed3c18-6cff-c6d4-a628-81f1f71b21dc@amd.com>
Message-ID: <496A3732-C91B-48B0-9DBB-126108174D93@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On April 7, 2022 7:57:22 AM PDT, Brijesh Singh <brijesh=2Esingh@amd=2Ecom> =
wrote:
>
>
>On 4/6/22 16:19, Thomas Gleixner wrote:
>> On Mon, Mar 07 2022 at 15:33, Brijesh Singh wrote:
>>>  =20
>>> +/*
>>> + * AMD SEV Confidential computing blob structure=2E The structure is
>>> + * defined in OVMF UEFI firmware header:
>>> + * https://github=2Ecom/tianocore/edk2/blob/master/OvmfPkg/Include/Gu=
id/ConfidentialComputingSevSnpBlob=2Eh
>>> + */
>>> +#define CC_BLOB_SEV_HDR_MAGIC	0x45444d41
>>> +struct cc_blob_sev_info {
>>> +	u32 magic;
>>> +	u16 version;
>>> +	u16 reserved;
>>> +	u64 secrets_phys;
>>> +	u32 secrets_len;
>>> +	u32 rsvd1;
>>> +	u64 cpuid_phys;
>>> +	u32 cpuid_len;
>>> +	u32 rsvd2;
>>> +};
>>=20
>> Shouldn't this be packed?
>>=20
>
>Yep, to avoid any additional compiler alignment we should pack it=2E
>
>thanks

It shouldn't be *necessary*, any more than it is necessary for kernel-user=
 space structures, since EFI is a C-based ABI=2E On x86 it doesn't hurt, ei=
ther, though, so might as well=2E
