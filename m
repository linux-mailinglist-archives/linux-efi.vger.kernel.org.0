Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503A05A1A09
	for <lists+linux-efi@lfdr.de>; Thu, 25 Aug 2022 22:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243526AbiHYUJn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 25 Aug 2022 16:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiHYUJk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 25 Aug 2022 16:09:40 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE836BFC5C
        for <linux-efi@vger.kernel.org>; Thu, 25 Aug 2022 13:09:38 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id l7so21739283vsc.0
        for <linux-efi@vger.kernel.org>; Thu, 25 Aug 2022 13:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/o5u98fJkAPGGPRvZ0JnL9MrzWUgTcXH/oohHXk3MD8=;
        b=Ezi3cLxl5SBn+0WFQppba1X7+DdHeAZwd+3+8yyHBkZ8p32tIpXd4owl1HlE83sJlO
         35tGqyLcydDFnVxl+CllN9bqMX9roI42WPfmwop0omLlw8YncOW+c8HsYJX/9B/vbTyJ
         G0ggnVxnzwnyWSTVI870+xJVwDivl/otgYRGldLDtzhFC+NR8TQKY25dlVrK2AY5pxqg
         j8+1wMEzuZoPbCH0bnMmY/aShcHogX5ZkHm8OOmT0W1plozwcVxwRnNem25RQcP/v+8v
         cOYAMOSYJKqvLMMxImuVQpmqla9mEyo5zBXp/yPnp1NiDw1AX/9F/iOoYCV+y7vg+ryK
         bZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/o5u98fJkAPGGPRvZ0JnL9MrzWUgTcXH/oohHXk3MD8=;
        b=3ndUs9uC49jX9RuGMYKiCmefWvtrxWdz39S9EOONXXM2dtDKNfcSl8v8vscyvtuRpZ
         fd5DLb7h2+3yVfpS9ZeVs7kiJlXr4WbzToXLWZUmmSxYOBzEVknr3jhDJAwXnb8qTUTu
         XxQTyP5mZ9UsFOQeKL6Z9Wu4hSbdbkmDIJHoNYySlKsGDD5agIC2ziWIgaE8JNrUyAAx
         VdxeEuuQmhyTbL4mvSzwx58xlOn3/dyUE4yFNC7VW6tbcswcUFByCPfR1YGeiWymEeg4
         NUyYV9c4gLmhlZfkNY1dHMtjTx08LC61Se4lWtJlXyBdHm9qkeTDQb2PQ4aeqGSsVN3E
         qvZQ==
X-Gm-Message-State: ACgBeo0/ayq2f5AKwW/9TQ3dSzpYDicXuxRk0vVlILfKyf2U4WjdfctO
        cWENc1VRfd0WsHQe6EVREpeki+Hjhgd/lsUsQp/LeA==
X-Google-Smtp-Source: AA6agR7nyEzEvgpeTs849VA7+3zgZ0xGJ1Pxf0VO2EuGO24TVf9MLwl1oV6f4IzTsrHTAKLU/CRN4th7Cmzsf8Yp7TA=
X-Received: by 2002:a67:fd0e:0:b0:390:1d9a:2455 with SMTP id
 f14-20020a67fd0e000000b003901d9a2455mr2104726vsr.78.1661458177919; Thu, 25
 Aug 2022 13:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220307213356.2797205-1-brijesh.singh@amd.com>
 <20220307213356.2797205-44-brijesh.singh@amd.com> <CAAH4kHYm1BhjJXUMH12kzR0Xun=fUTj-3Hy6At0XR_09Bf0Ccw@mail.gmail.com>
 <CAMkAt6oKQ3CnmNdrJLMWreExkN56t9vs=B883_JD+HtiNYw9HA@mail.gmail.com> <51298b17-9e12-7a08-7322-594deac52f53@amd.com>
In-Reply-To: <51298b17-9e12-7a08-7322-594deac52f53@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Thu, 25 Aug 2022 14:09:26 -0600
Message-ID: <CAMkAt6qBd7uoR-9NW7HbcE-N7w++3vGsviGLkhmVbnZ5TH3ZOg@mail.gmail.com>
Subject: Re: [PATCH v12 43/46] virt: Add SEV-SNP guest driver
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 25, 2022 at 12:54 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 8/24/22 14:28, Peter Gonda wrote:
> > On Wed, Aug 24, 2022 at 12:01 PM Dionna Amalie Glaze
> > <dionnaglaze@google.com> wrote:
> >>
> >> Apologies for the necropost, but I noticed strange behavior testing my
> >> own Golang-based wrapper around the /dev/sev-guest driver.
> >>
> >>> +
> >>> +static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
> >>> +                               u8 type, void *req_buf, size_t req_sz, void *resp_buf,
> >>> +                               u32 resp_sz, __u64 *fw_err)
> >>> +{
> >>> +       unsigned long err;
> >>> +       u64 seqno;
> >>> +       int rc;
> >>> +
> >>> +       /* Get message sequence and verify that its a non-zero */
> >>> +       seqno = snp_get_msg_seqno(snp_dev);
> >>> +       if (!seqno)
> >>> +               return -EIO;
> >>> +
> >>> +       memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
> >>> +
> >>> +       /* Encrypt the userspace provided payload */
> >>> +       rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
> >>> +       if (rc)
> >>> +               return rc;
> >>> +
> >>> +       /* Call firmware to process the request */
> >>> +       rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
> >>> +       if (fw_err)
> >>> +               *fw_err = err;
> >>> +
> >>> +       if (rc)
> >>> +               return rc;
> >>> +
> >>
> >> The fw_err is written back regardless of rc, so since err is
> >> uninitialized, you can end up with garbage written back. I've worked
> >> around this by only caring about fw_err when the result is -EIO, but
> >> thought that I should bring this up.
> >
> > I also noticed that we use a u64 in snp_guest_request_ioctl.fw_err and
> > u32 in sev_issue_cmd.error when these should be errors from the
> > sev_ret_code enum IIUC.
>
> The reason for the u64 is that the Extended Guest Request can return a
> firmware error or a hypervisor error. To distinguish between the two, a
> firmware error is contained in the lower 32-bits, while a hypervisor error
> is contained in the upper 32-bits (e.g. when not enough contiguous pages
> of memory have been supplied).

Ah, makes sense. I was trying to think of a way to codify the state
described above where we error so early in the IOCTL or call that the
PSP is never called, something like below. I think using UINT32_MAX
still works with how u64 of Extended Guest Request is spec'd. Is this
interesting to clean up the PSP driver and internal calls, and the new
sev-guest driver?

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 63dc626627a0..d1e605567d5e 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -22,6 +22,7 @@
 #include <linux/efi.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/psp-sev.h>

 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -2177,6 +2178,8 @@ int snp_issue_guest_request(u64 exit_code,
struct snp_req_data *input, unsigned
        if (!fw_err)
                return -EINVAL;

+       fw_err = SEV_RET_NO_FW_CALL;
+
        /*
         * __sev_get_ghcb() needs to run with IRQs disabled because it is using
         * a per-CPU GHCB.
@@ -2209,6 +2212,8 @@ int snp_issue_guest_request(u64 exit_code,
struct snp_req_data *input, unsigned
                *fw_err = ghcb->save.sw_exit_info_2;

                ret = -EIO;
+       } else {
+               *fw_err = 0;
        }

 e_put:
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 9f588c9728f8..e71d6e39aa2b 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -439,7 +439,7 @@ static int __sev_platform_init_locked(int *error)
 {
        struct psp_device *psp = psp_master;
        struct sev_device *sev;
-       int rc, psp_ret = -1;
+       int rc, psp_ret = SEV_RET_NO_FW_CALL;
        int (*init_function)(int *error);

        if (!psp || !psp->sev_data)
diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
index 91b4c63d5cbf..b8f2c129d63d 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -36,6 +36,11 @@ enum {
  * SEV Firmware status code
  */
...skipping...

 #include <asm/cpu_entry_area.h>
 #include <asm/stacktrace.h>
@@ -2177,6 +2178,8 @@ int snp_issue_guest_request(u64 exit_code,
struct snp_req_data *input, unsigned
        if (!fw_err)
                return -EINVAL;

+       fw_err = SEV_RET_NO_FW_CALL;
+
        /*
         * __sev_get_ghcb() needs to run with IRQs disabled because it is using
         * a per-CPU GHCB.
@@ -2209,6 +2212,8 @@ int snp_issue_guest_request(u64 exit_code,
struct snp_req_data *input, unsigned
                *fw_err = ghcb->save.sw_exit_info_2;

                ret = -EIO;
+       } else {
+               *fw_err = 0;
        }

 e_put:
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 9f588c9728f8..e71d6e39aa2b 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -439,7 +439,7 @@ static int __sev_platform_init_locked(int *error)
 {
        struct psp_device *psp = psp_master;
        struct sev_device *sev;
-       int rc, psp_ret = -1;
+       int rc, psp_ret = SEV_RET_NO_FW_CALL;
        int (*init_function)(int *error);

        if (!psp || !psp->sev_data)
diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
index 91b4c63d5cbf..b8f2c129d63d 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -36,6 +36,11 @@ enum {
  * SEV Firmware status code
  */
 typedef enum {
+       /*
+        * This error code is not in the SEV spec but is added to convey that
+        * there was an error that prevented the SEV Firmware from being called.
+        */
+       SEV_RET_NO_FW_CALL = -1,
        SEV_RET_SUCCESS = 0,
        SEV_RET_INVALID_PLATFORM_STATE,
        SEV_RET_INVALID_GUEST_STATE,




> >
> >>
> >> --
> >> -Dionna Glaze, PhD (she/her)
