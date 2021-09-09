Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 457124059BD
	for <lists+linux-efi@lfdr.de>; Thu,  9 Sep 2021 16:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhIIO4K (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Sep 2021 10:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhIIO4J (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Sep 2021 10:56:09 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6349C061574
        for <linux-efi@vger.kernel.org>; Thu,  9 Sep 2021 07:54:59 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id k13so4287127lfv.2
        for <linux-efi@vger.kernel.org>; Thu, 09 Sep 2021 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UXDQZf9GzYNTEO852SsaCLl2x7HS0RgCfhZ04IuDC2I=;
        b=JmUdq4Wh16MijW68342W/rE/D7fXFeyOtoOKzi7u5wegZlDayNEemJqHGu5Pv9EMfv
         O3yK5jfNQWOv+JhpDuIV1LnSI8PjS94xPdjGuAh6yNEjkIA3yAAuqUzLCjqCyFCcN6Xo
         daekX6B2mNlFawoQnV15OrMMyQnvV/c8uxXZZHnLaac/lpU7GY10oJNGM/R0/6e+Y/gF
         QEPBHJHHCWohS5g2kCmcODC7rfSbNA6i9Zm/KIuokcvwlMC0Yv1Py+laDT43vW6WiH4I
         VHVpfJDllRA41xwd+PYM8PhubIV9K0ym+dGqP0Yv3CvIE0iosrl1Xz/C/NAcPMAeBjK+
         IsqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UXDQZf9GzYNTEO852SsaCLl2x7HS0RgCfhZ04IuDC2I=;
        b=XcmA+VJ2sMyCNoZ2LC9N5wfvIZpsFEVtulU0s6ivDHk+K58bQEJDdusbXbu4SAgLQN
         VPEYpLsab3Mn+Fazh7l0z7Oio0ZiC8D6eaCIpzA2O5Nd90TrU8mx7nc8tely3bqLu8lA
         r4QHtXCYptNeZJXAriftrbMOKesGHT1Dj6ASnADVT8Mi24l5tew/b4WNRCaAXeYerpRf
         slZ7x2vTkz4Zy5zTq0M9j5j8ODIaDWVydiQmkzR7jLIHv5utc6frUTUPYWQ5Qo6bEG8g
         USZgFhS4ZYoU3ua2YdQR4mNTN6nvFTRPbuUibj2IxQQjRDQYcTUMlexIFJrY59UR8tP9
         1+gQ==
X-Gm-Message-State: AOAM531rQLY6W1hCyiizhwsFkwtBKPZFuF0n68+CUZQjldhe2e1BQQ6f
        6PMcPEvzeiWHKx+/WLMP4pF6QwJGRtky2BQOljER6A==
X-Google-Smtp-Source: ABdhPJzVlDJrIFcJ2i81VlE5b1q6SgGaZDssMEI+LEFLRhNJoDi+tgy/aITWYuMKp0ppmEZ9S1Cumb8525ItJFbkX28=
X-Received: by 2002:a05:6512:1112:: with SMTP id l18mr204163lfg.402.1631199297810;
 Thu, 09 Sep 2021 07:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210820151933.22401-1-brijesh.singh@amd.com> <20210820151933.22401-35-brijesh.singh@amd.com>
In-Reply-To: <20210820151933.22401-35-brijesh.singh@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Thu, 9 Sep 2021 08:54:46 -0600
Message-ID: <CAMkAt6qQOgZVEMQdMXqvs2s8pELnAFV-Msgc2_MC5WOYf8oAiQ@mail.gmail.com>
Subject: Re: [PATCH Part1 v5 34/38] x86/sev: Add snp_msg_seqno() helper
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        kvm list <kvm@vger.kernel.org>, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-coco@lists.linux.dev,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
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
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        Marc Orr <marcorr@google.com>,
        sathyanarayanan.kuppuswamy@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 20, 2021 at 9:22 AM Brijesh Singh <brijesh.singh@amd.com> wrote:
>
> The SNP guest request message header contains a message count. The
> message count is used while building the IV. The PSP firmware increments
> the message count by 1, and expects that next message will be using the
> incremented count. The snp_msg_seqno() helper will be used by driver to
> get the message sequence counter used in the request message header,
> and it will be automatically incremented after the request is successful.
> The incremented value is saved in the secrets page so that the kexec'ed
> kernel knows from where to begin.
>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kernel/sev.c     | 79 +++++++++++++++++++++++++++++++++++++++
>  include/linux/sev-guest.h | 37 ++++++++++++++++++
>  2 files changed, 116 insertions(+)
>
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 319a40fc57ce..f42cd5a8e7bb 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -51,6 +51,8 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
>   */
>  static struct ghcb __initdata *boot_ghcb;
>
> +static u64 snp_secrets_phys;
> +
>  /* #VC handler runtime per-CPU data */
>  struct sev_es_runtime_data {
>         struct ghcb ghcb_page;
> @@ -2030,6 +2032,80 @@ bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
>                 halt();
>  }
>
> +static struct snp_secrets_page_layout *snp_map_secrets_page(void)
> +{
> +       u16 __iomem *secrets;
> +
> +       if (!snp_secrets_phys || !sev_feature_enabled(SEV_SNP))
> +               return NULL;
> +
> +       secrets = ioremap_encrypted(snp_secrets_phys, PAGE_SIZE);
> +       if (!secrets)
> +               return NULL;
> +
> +       return (struct snp_secrets_page_layout *)secrets;
> +}
> +
> +static inline u64 snp_read_msg_seqno(void)
> +{
> +       struct snp_secrets_page_layout *layout;
> +       u64 count;
> +
> +       layout = snp_map_secrets_page();
> +       if (!layout)
> +               return 0;
> +
> +       /* Read the current message sequence counter from secrets pages */
> +       count = readl(&layout->os_area.msg_seqno_0);
> +
> +       iounmap(layout);
> +
> +       /* The sequence counter must begin with 1 */
> +       if (!count)
> +               return 1;
> +
> +       return count + 1;
> +}
> +
> +u64 snp_msg_seqno(void)
> +{
> +       u64 count = snp_read_msg_seqno();
> +
> +       if (unlikely(!count))
> +               return 0;
> +
> +       /*
> +        * The message sequence counter for the SNP guest request is a
> +        * 64-bit value but the version 2 of GHCB specification defines a
> +        * 32-bit storage for the it.
> +        */
> +       if (count >= UINT_MAX)
> +               return 0;
> +
> +       return count;
> +}
> +EXPORT_SYMBOL_GPL(snp_msg_seqno);

Do we need some sort of get sequence number, then ack that sequence
number was used API? Taking your host changes in Part2 V5 as an
example. If 'snp_setup_guest_buf' fails the given sequence number is
never actually used by a message to the PSP. So the guest will have
the wrong current sequence number, an off by 1 error, right?

Also it seems like there is a concurrency error waiting to happen
here. If 2 callers call snp_msg_seqno() before either actually places
a call to the PSP, if the first caller's request doesn't reach the PSP
before the second caller's request both calls will fail. And again I
think the sequence numbers in the guest will be incorrect and
unrecoverable.

> +
> +static void snp_gen_msg_seqno(void)
> +{
> +       struct snp_secrets_page_layout *layout;
> +       u64 count;
> +
> +       layout = snp_map_secrets_page();
> +       if (!layout)
> +               return;
> +
> +       /*
> +        * The counter is also incremented by the PSP, so increment it by 2
> +        * and save in secrets page.
> +        */
> +       count = readl(&layout->os_area.msg_seqno_0);
> +       count += 2;
> +
> +       writel(count, &layout->os_area.msg_seqno_0);
> +       iounmap(layout);
> +}
> +
>  int snp_issue_guest_request(int type, struct snp_guest_request_data *input, unsigned long *fw_err)
>  {
>         struct ghcb_state state;
> @@ -2077,6 +2153,9 @@ int snp_issue_guest_request(int type, struct snp_guest_request_data *input, unsi
>                 ret = -EIO;
>         }
>
> +       /* The command was successful, increment the sequence counter */
> +       snp_gen_msg_seqno();
> +
>  e_put:
>         __sev_put_ghcb(&state);
>  e_restore_irq:
> diff --git a/include/linux/sev-guest.h b/include/linux/sev-guest.h
> index 24dd17507789..16b6af24fda7 100644
> --- a/include/linux/sev-guest.h
> +++ b/include/linux/sev-guest.h
> @@ -20,6 +20,41 @@ enum vmgexit_type {
>         GUEST_REQUEST_MAX
>  };
>
> +/*
> + * The secrets page contains 96-bytes of reserved field that can be used by
> + * the guest OS. The guest OS uses the area to save the message sequence
> + * number for each VMPCK.
> + *
> + * See the GHCB spec section Secret page layout for the format for this area.
> + */
> +struct secrets_os_area {
> +       u32 msg_seqno_0;
> +       u32 msg_seqno_1;
> +       u32 msg_seqno_2;
> +       u32 msg_seqno_3;
> +       u64 ap_jump_table_pa;
> +       u8 rsvd[40];
> +       u8 guest_usage[32];
> +} __packed;
> +
> +#define VMPCK_KEY_LEN          32
> +
> +/* See the SNP spec for secrets page format */
> +struct snp_secrets_page_layout {
> +       u32 version;
> +       u32 imien       : 1,
> +           rsvd1       : 31;
> +       u32 fms;
> +       u32 rsvd2;
> +       u8 gosvw[16];
> +       u8 vmpck0[VMPCK_KEY_LEN];
> +       u8 vmpck1[VMPCK_KEY_LEN];
> +       u8 vmpck2[VMPCK_KEY_LEN];
> +       u8 vmpck3[VMPCK_KEY_LEN];
> +       struct secrets_os_area os_area;
> +       u8 rsvd3[3840];
> +} __packed;
> +
>  /*
>   * The error code when the data_npages is too small. The error code
>   * is defined in the GHCB specification.
> @@ -36,6 +71,7 @@ struct snp_guest_request_data {
>  #ifdef CONFIG_AMD_MEM_ENCRYPT
>  int snp_issue_guest_request(int vmgexit_type, struct snp_guest_request_data *input,
>                             unsigned long *fw_err);
> +u64 snp_msg_seqno(void);
>  #else
>
>  static inline int snp_issue_guest_request(int type, struct snp_guest_request_data *input,
> @@ -43,6 +79,7 @@ static inline int snp_issue_guest_request(int type, struct snp_guest_request_dat
>  {
>         return -ENODEV;
>  }
> +static inline u64 snp_msg_seqno(void) { return 0; }
>
>  #endif /* CONFIG_AMD_MEM_ENCRYPT */
>  #endif /* __LINUX_SEV_GUEST_H__ */
> --
> 2.17.1
>
>
