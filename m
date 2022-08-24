Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DAC5A0217
	for <lists+linux-efi@lfdr.de>; Wed, 24 Aug 2022 21:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbiHXT3D (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 24 Aug 2022 15:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239916AbiHXT3C (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 24 Aug 2022 15:29:02 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FEF78BD1
        for <linux-efi@vger.kernel.org>; Wed, 24 Aug 2022 12:29:00 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id x25so17352019ljm.5
        for <linux-efi@vger.kernel.org>; Wed, 24 Aug 2022 12:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ud6LSmJPhrEe1O3tH9bfACVlWJ+Fj1pwj346rUu8aFw=;
        b=Z2jM1L6bkJVPjP2DKAJljcsyrOOrVaGqJLAqzlKrZ639M1ou4W+gt6VEnZfM9GIMCF
         SeUBSTwTEy/ugCEIoJSMg5gpQiXV/YW8/zFDEiaz/lWm7DXElQFdhc17HKi9O+Y2CZkL
         LhgOKoPXstdnGWEeMhiyY+aOF3HfM663rHuZK+6w6NIL9v3qCSiPAEZX+aiF0FQg3jWf
         pv7cfJk+q0TMm2WecwsV5HTEjCEihc3UL8NuZ65x8xj93UAjZQQwIdmU3F/yvrkvP4aa
         azCkdsSTY4R3TVzoCkUDFq7dX8KwGtjjKyO7z02ZdXK1aG1zPFzRiwWJpd0Ss4+9b9BD
         INIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ud6LSmJPhrEe1O3tH9bfACVlWJ+Fj1pwj346rUu8aFw=;
        b=VlXJoqG2SQBGN6F77MxwkuWlorWEUKTc/v1Kp9jnye3O5D3QSA0vZi0vwGubkA/PXu
         aOVvqj7MpnWyarOvwAQG5fgYWHNh2SVPgfVw+fDJ6L+C0EMtHKrVY8mMg5s3R11XaQk9
         lKTeUPasZ1kPFX3q72BA0bcDJyFUMhpiLiBeDykWLUsoC9y/Qt3IeKXKIraHkZRsPqbo
         XKSPx8j3w/hyV9UP5v1v+MF/ORNTCM/OJ2upF8nuHld7qpXvwSW8KWg1FPrR1V/PO7k2
         U++iA+OmVwDdg5oP0fOKTa4XFkE/gJeDDmjgGSFlJVCHQPq9yaK0et3P1QpbZ0AmzfgM
         uInQ==
X-Gm-Message-State: ACgBeo3L8/Fuj/dD4EFVe9Ca5ZydgCTwili3bQCZJkU9UKPmID7KnlHn
        in1gri4Z45lhD7I83EngxHOld0wzA5D5ElQnKOjzvg==
X-Google-Smtp-Source: AA6agR6qzB+SDh82GOibU+ibPmxm9norlNaWBI74hZciCbfvsiOsZDachVztTY0d9cfRDTTu6O2cHU/LynXQAo0SUJw=
X-Received: by 2002:a2e:9ad2:0:b0:261:cbdd:1746 with SMTP id
 p18-20020a2e9ad2000000b00261cbdd1746mr181526ljj.486.1661369338801; Wed, 24
 Aug 2022 12:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
 <20220307213356.2797205-44-brijesh.singh@amd.com> <CAAH4kHYm1BhjJXUMH12kzR0Xun=fUTj-3Hy6At0XR_09Bf0Ccw@mail.gmail.com>
In-Reply-To: <CAAH4kHYm1BhjJXUMH12kzR0Xun=fUTj-3Hy6At0XR_09Bf0Ccw@mail.gmail.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 24 Aug 2022 13:28:47 -0600
Message-ID: <CAMkAt6oKQ3CnmNdrJLMWreExkN56t9vs=B883_JD+HtiNYw9HA@mail.gmail.com>
Subject: Re: [PATCH v12 43/46] virt: Add SEV-SNP guest driver
To:     Dionna Amalie Glaze <dionnaglaze@google.com>
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:X86 KVM CPUs" <kvm@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-coco@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 24, 2022 at 12:01 PM Dionna Amalie Glaze
<dionnaglaze@google.com> wrote:
>
> Apologies for the necropost, but I noticed strange behavior testing my
> own Golang-based wrapper around the /dev/sev-guest driver.
>
> > +
> > +static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
> > +                               u8 type, void *req_buf, size_t req_sz, void *resp_buf,
> > +                               u32 resp_sz, __u64 *fw_err)
> > +{
> > +       unsigned long err;
> > +       u64 seqno;
> > +       int rc;
> > +
> > +       /* Get message sequence and verify that its a non-zero */
> > +       seqno = snp_get_msg_seqno(snp_dev);
> > +       if (!seqno)
> > +               return -EIO;
> > +
> > +       memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
> > +
> > +       /* Encrypt the userspace provided payload */
> > +       rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
> > +       if (rc)
> > +               return rc;
> > +
> > +       /* Call firmware to process the request */
> > +       rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
> > +       if (fw_err)
> > +               *fw_err = err;
> > +
> > +       if (rc)
> > +               return rc;
> > +
>
> The fw_err is written back regardless of rc, so since err is
> uninitialized, you can end up with garbage written back. I've worked
> around this by only caring about fw_err when the result is -EIO, but
> thought that I should bring this up.

I also noticed that we use a u64 in snp_guest_request_ioctl.fw_err and
u32 in sev_issue_cmd.error when these should be errors from the
sev_ret_code enum IIUC.

We can fix snp_issue_guest_request() to set |fw_err| to zero when it
returns 0 but what should we return to userspace if we encounter an
error that prevents the FW from even being called? In ` crypto: ccp -
Ensure psp_ret is always init'd in __sev_platform_init_locked()` we
set the return to -1 so we could continue that convection here and
better codify it in the sev_ret_code enum.

>
> --
> -Dionna Glaze, PhD (she/her)
