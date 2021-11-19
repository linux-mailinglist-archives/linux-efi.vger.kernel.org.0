Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C48145729B
	for <lists+linux-efi@lfdr.de>; Fri, 19 Nov 2021 17:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236358AbhKSQTg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Nov 2021 11:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbhKSQTf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Nov 2021 11:19:35 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BA2C061748
        for <linux-efi@vger.kernel.org>; Fri, 19 Nov 2021 08:16:33 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id bu18so45911495lfb.0
        for <linux-efi@vger.kernel.org>; Fri, 19 Nov 2021 08:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PT99iXBgpFIqepfqqbxcYIJQ3M5siuSp1UK8d1YL76U=;
        b=jHnYvtbACgEqbUWh2jxPk+A/JrzDhbXD8GN8W5j+q116oOn4I3SOuYu6WXCtrrggre
         F7RpoUb/u9Up8UEnvaefDtRgviWR4D0TRw1rW/Phwc80x7ZOoDd8O2dfgi/c+ROR+lX5
         Yy2fFiZqBJ5+RA1uTtjpnhhyj1hCKxOF02fIylR+5hy8M6tyWFndK21K7bQVKGshQUbZ
         i/FNRVp4LEQcjTlUBmMdV3GUS7OuM5jx1rMJe4MjQZPdej9ePypZgGW9aGrETXY4QiZp
         kerRyGX2XuCWsfQK8QYTwunTBoAEJdQvm1+FgZtHsirRQWxrNm3WV5XlSKSARBFjr8R5
         GQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PT99iXBgpFIqepfqqbxcYIJQ3M5siuSp1UK8d1YL76U=;
        b=HLGYdhbpYqCCtSSljAO3UTNHwq0e3grwDcSc9lFresQfkz+6XAf9aFo5sj7fHYALOT
         lhCZGLQ8nyUOkeZbQMOqHlLmbUGWXcdY56+LpYg2/DgiEULOe0rnsi+eWseUEK5UgNs2
         1UC3QWVj++nn1LkN1gK7eTlzTZv62G1drmgSPG+N9vRLgbOT+EYdLu3fCdu3HAMleEsd
         U8OCDQZhcUHnXyXMIKEYzkPjEiD5PnvSP7/vQIMsSnASAoMlvlCEJPiA3Iq1+B6HXex4
         NPuZGrBgf5C+Bt5TAT+jhbPy+sn8Gg0mKoI5lNOKbIrSyu8WZ2tHNlGXVau97kJYbduU
         UZEA==
X-Gm-Message-State: AOAM532cOfspZ74ec2P9Qeqr5y/2UM3sdJrwqs5pLGdsI5JRburaIyJk
        lUVKZOjkW5kMuC0o8H0uKRQ7affAyy4JgssYIQ9egg==
X-Google-Smtp-Source: ABdhPJyWR8stzdTiCGjrREyonaNUfQgQWz4uaz8HWtQNIMD89ICA71wJAEljhEu8NgU+6QnOvVwM8eP3k2kVjE8qGLw=
X-Received: by 2002:a2e:9f15:: with SMTP id u21mr26972655ljk.132.1637338591736;
 Fri, 19 Nov 2021 08:16:31 -0800 (PST)
MIME-Version: 1.0
References: <20211110220731.2396491-1-brijesh.singh@amd.com>
 <20211110220731.2396491-44-brijesh.singh@amd.com> <CAMkAt6q3D4h=01XhHcxXTEwbWLM9CnAaq+6vgNzxyqzt+X00UQ@mail.gmail.com>
 <ff3ceeb5-e120-fe07-2a0c-4cd51f552db8@amd.com>
In-Reply-To: <ff3ceeb5-e120-fe07-2a0c-4cd51f552db8@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Fri, 19 Nov 2021 09:16:20 -0700
Message-ID: <CAMkAt6pAcM-+odnagFTiaY7PPGE1CfAt27x=tG=-4UU9c+dQXA@mail.gmail.com>
Subject: Re: [PATCH v7 43/45] virt: Add SEV-SNP guest driver
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
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
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Nov 18, 2021 at 10:32 AM Brijesh Singh <brijesh.singh@amd.com> wrote:
>
>
>
> On 11/17/21 5:34 PM, Peter Gonda wrote:
>
>
> >> +The guest ioctl should be issued on a file descriptor of the /dev/sev-guest device.
> >> +The ioctl accepts struct snp_user_guest_request. The input and output structure is
> >> +specified through the req_data and resp_data field respectively. If the ioctl fails
> >> +to execute due to a firmware error, then fw_err code will be set.
> >
> > Should way say what it will be set to? Also Sean pointed out on CCP
> > driver that 0 is strange to set the error to, its a uint so we cannot
> > do -1 like we did there. What about all FFs?
> >
>
> Sure, all FF's works, I can document and use it.
>
>
> >> +static inline u64 __snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
> >> +{
> >> +       u64 count;
> >
> > I may be overly paranoid here but how about
> > `lockdep_assert_held(&snp_cmd_mutex);` when writing or reading
> > directly from this data?
> >
>
> Sure, I can do it.
>
> ...
>
> >> +
> >> +       if (rc)
> >> +               return rc;
> >> +
> >> +       rc = verify_and_dec_payload(snp_dev, resp_buf, resp_sz);
> >> +       if (rc) {
> >> +               /*
> >> +                * The verify_and_dec_payload() will fail only if the hypervisor is
> >> +                * actively modifiying the message header or corrupting the encrypted payload.
> > modifiying
> >> +                * This hints that hypervisor is acting in a bad faith. Disable the VMPCK so that
> >> +                * the key cannot be used for any communication.
> >> +                */
> >
> > This looks great, thanks for changes Brijesh. Should we mention in
> > comment here or at snp_disable_vmpck() the AES-GCM issues with
> > continuing to use the key? Or will future updaters to this code
> > understand already?
> >
>
> Sure, I can add comment about the AES-GCM.
>
> ...
>
> >> +
> >> +/* See SNP spec SNP_GUEST_REQUEST section for the structure */
> >> +enum msg_type {
> >> +       SNP_MSG_TYPE_INVALID = 0,
> >> +       SNP_MSG_CPUID_REQ,
> >> +       SNP_MSG_CPUID_RSP,
> >> +       SNP_MSG_KEY_REQ,
> >> +       SNP_MSG_KEY_RSP,
> >> +       SNP_MSG_REPORT_REQ,
> >> +       SNP_MSG_REPORT_RSP,
> >> +       SNP_MSG_EXPORT_REQ,
> >> +       SNP_MSG_EXPORT_RSP,
> >> +       SNP_MSG_IMPORT_REQ,
> >> +       SNP_MSG_IMPORT_RSP,
> >> +       SNP_MSG_ABSORB_REQ,
> >> +       SNP_MSG_ABSORB_RSP,
> >> +       SNP_MSG_VMRK_REQ,
> >> +       SNP_MSG_VMRK_RSP,
> >
> > Did you want to include MSG_ABSORB_NOMA_REQ and MSG_ABSORB_NOMA_RESP here?
> >
>
> Yes, I can includes those for the completeness.
>
> ...
>
> >> +struct snp_report_req {
> >> +       /* message version number (must be non-zero) */
> >> +       __u8 msg_version;
> >> +
> >> +       /* user data that should be included in the report */
> >> +       __u8 user_data[64];
> >
> > Are we missing the 'vmpl' field here? Does those default all requests
> > to be signed with VMPL0? Users might want to change that, they could
> > be using a paravisor.
> >
>
> Good question, so far I was thinking that guest kernel will provide its
> vmpl level instead of accepted the vmpl level from the userspace. Do you
> see a need for a userspace to provide this information ?

That seems fine. I am just confused because we are just encrypting
this struct as the payload for the PSP. Doesn't the message require a
struct that looks like 'snp_report_req_user_data' below?

snp_report_req{
       /* message version number (must be non-zero) */
       __u8 msg_version;

      /* user data that should be included in the report */
       struct snp_report_req_user_data;
};

struct snp_report_req_user_data {
  u8 user_data[64];
  u32 vmpl;
  u32 reserved;
};


>
>
> thanks
