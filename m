Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D917288D1
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jun 2023 21:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjFHTji (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Jun 2023 15:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjFHTjg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Jun 2023 15:39:36 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6174A134
        for <linux-efi@vger.kernel.org>; Thu,  8 Jun 2023 12:39:34 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b1badb8f9bso10151261fa.1
        for <linux-efi@vger.kernel.org>; Thu, 08 Jun 2023 12:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686253172; x=1688845172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rRPRuQnm3+oJHVqcDvP4QLGvWW7hCToB0kEigLBi5Sw=;
        b=MqtfuwrwoXunFIgZ/c0qiydszJ0AunfmOWkPIYtoDzZbt1FvUCW8J8P8MWgWG+UvvY
         pq3YMyEm8LDbLx+Bdfb/WW4XHbSTlbhNF28HjkBjoN0WRwtccaQKcIG96BHYgXK9vS3J
         r3IzsK66JFIuwHM5y1stPv7X2q9w1t1xEMQmaSbagOeGl0bsTAZnmZstkRwwxRRy8ZEu
         /3Ygc/aPl4s+7MFsViqFVH2k30CsnTwjGVmFpSPFxjk8XHDkpzBFUPA5F+vaeFVA4zsd
         1MJ0pK839LaeX4CB4b6w2F2/AJ6GgaP4Pom0Es/PhcXeTaYN+6OSElfKBo3nK7/jn+Bc
         xMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686253172; x=1688845172;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRPRuQnm3+oJHVqcDvP4QLGvWW7hCToB0kEigLBi5Sw=;
        b=M9n4B/YcctSN72JosOYND2ZebY26jHm8G2itFCOKUZNWrcqKHWod+tGWlm1+4tHuJa
         K+bJXQ08sr1r2qAm9Pa/WD3+kSSPFNamjFESLJaqdBDxRAQPZKaPFvGODIuYwrYDvu3I
         cJ8e5kcgtQ8v8Bh7VPO+mscr7PCrCaE6dreohtamqSKyVt9haLLIsTSpYDrlH91iXQHI
         8+SwhuXTvdM7A2F+/+BMrl+CaicjrItUhxjQSjOdWnA600MonoEfELItkl4ICM2j0veH
         K8KRqDyjfN9LuTxlDf0ifRmiBRFzGNdwW1Ws7wVH7Sk2Xn0RL9k4wEndb9pSmfwMNNSw
         YKMw==
X-Gm-Message-State: AC+VfDzmq43epijNZH0eMxQe9teia6rIj0l+ZS/rlZFyr8V9lcmzmCF6
        8hOY8ER0bFqDhuLxFRn5uHp5ByJ3Cx8t+Uw9xeYPZA==
X-Google-Smtp-Source: ACHHUZ6zEoO5efIpGi6tUy3VNo4VtAQpuLQUlVsYtKFXVwHywcjwevCv3ef4/qmukxsUrd93VbQyvfstDsBkDV+kR/4=
X-Received: by 2002:a2e:a408:0:b0:2b2:52:7eea with SMTP id p8-20020a2ea408000000b002b200527eeamr2350364ljn.48.1686253172550;
 Thu, 08 Jun 2023 12:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230526010748.1222-1-masahisa.kojima@linaro.org>
 <20230526010748.1222-4-masahisa.kojima@linaro.org> <0d3e0370-eb76-010f-3d30-9acc9b59645c@siemens.com>
 <CAFA6WYPnWJNPvhT2JDkO-qXRUaJoxBGZEvSfhxcRynV7=VSdQA@mail.gmail.com>
 <CAMj1kXFM45PCTU--+CCed6Cq_N5XqDG6tTu6fnQTSCpW2BWA5A@mail.gmail.com>
 <4ff09002-e871-38b9-43ec-227a64bac731@siemens.com> <CAC_iWjJJ5E9Q1or5yTiDynzv_WAYH-g+N24aRdu9rvcsbWqnrg@mail.gmail.com>
 <CAFA6WYNFYB1LiOFB_iwTsdD5PmnDdSbtDSH2J4FVFPx3uik8rQ@mail.gmail.com>
 <CAC_iWj+E7-XK6dCeSn4205K0O3EZCLxCaC+adu-14ST6sdudfA@mail.gmail.com>
 <76da826f-b608-6add-5401-6de818b180e3@siemens.com> <CAFA6WYPCDRjFzsUMU=SNzEt88nT7Fcm1eOFL8z4HiQO+=2JeVA@mail.gmail.com>
 <cc6bd203-83ea-c247-0986-7fec6f327ee8@siemens.com> <CAC_iWjKZNHJxq4VMFnV7oQngwBBCQveh=s34u1LZ59YUqViPbw@mail.gmail.com>
 <CAC_iWjJMv68yLC606SBhMmBYkR4wVC8SvUcPvNM=RX_qL=9Bvw@mail.gmail.com>
 <b9b8c1d3-fc8e-df94-d12b-a9e3debf3418@siemens.com> <CAC_iWj+cP4RfDNu_n-ZOp7A62W34drLpPszN_hrkqF_aPTLtMg@mail.gmail.com>
 <871ece13-7d6e-44d4-3bda-317658202f6f@siemens.com> <CAC_iWjKgCJWgKU8tC3Nfn-0CgwGhw89B3JpTgsjkjDDOcWZEdw@mail.gmail.com>
 <CAMj1kXGbXdbDr6DbyuziSFuxMgAimjNnkhqy8C-S5AbxdnixuQ@mail.gmail.com>
In-Reply-To: <CAMj1kXGbXdbDr6DbyuziSFuxMgAimjNnkhqy8C-S5AbxdnixuQ@mail.gmail.com>
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date:   Thu, 8 Jun 2023 22:38:56 +0300
Message-ID: <CAC_iWjJ0uw_p9=6C+U+q8BNQgnDBgbDpcu8s8c80oB25i9y77w@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] efi: Add tee-based EFI variable driver
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-efi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        "Su, Bao Cheng (RC-CN DF FA R&D)" <baocheng.su@siemens.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 8 Jun 2023 at 16:52, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 8 Jun 2023 at 08:22, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Jan
> >
> >
> > On Wed, 7 Jun 2023 at 22:46, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> > >
> > > On 07.06.23 20:17, Ilias Apalodimas wrote:
> > > > On Wed, 7 Jun 2023 at 20:14, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> > > >>
> > > >> On 07.06.23 18:59, Ilias Apalodimas wrote:
> > > >>> On Wed, 7 Jun 2023 at 19:09, Ilias Apalodimas
> > > >>> <ilias.apalodimas@linaro.org> wrote:
> > > >>>>
> > > >>>> Hi Jan,
> > > >>>>
> > > >>>> [...]
> > > >>>>>>>> No I don't, this will work reliably without the need to remount the efivarfs.
> > > >>>>>>>> As you point out you will still have this dependency if you end up
> > > >>>>>>>> building them as modules and you manage to mount the efivarfs before
> > > >>>>>>>> those get inserted.  Does anyone see a reasonable workaround?
> > > >>>>>>>> Deceiving the kernel and making the bootloader set the RT property bit
> > > >>>>>>>> to force the filesystem being mounted as rw is a nasty hack that we
> > > >>>>>>>> should avoid.  Maybe adding a kernel command line parameter that says
> > > >>>>>>>> "Ignore the RTPROP I know what I am doing"?  I don't particularly love
> > > >>>>>>>> this either, but it's not unreasonable.
> > > >>>>>>>
> > > >>>>>>> In the context of https://github.com/OP-TEE/optee_os/issues/6094,
> > > >>>>>>> basically this issue mapped on reboot/shutdown, I would really love to
> > > >>>>>>> see the unhandy tee-supplicant daemon to be overcome.
> > > >>>>>>
> > > >>>>>> I have seen this error before and it has been on my todo list. So I
> > > >>>>>> have tried to fix it here [1]. Feel free to test it and let me know if
> > > >>>>>> you see any further issues.
> > > >>>>>>
> > > >>>>>> [1] https://lkml.org/lkml/2023/6/7/927
> > > >>>>>>
> > > >>>>>
> > > >>>>> Ah, nice, will test ASAP!
> > > >>>>>
> > > >>>>> Meanwhile more food: I managed to build a firmware that was missing
> > > >>>>> STMM. But the driver loaded, and I got this:
> > > >>>>
> > > >>>> Thanks for the testing. I'll try to reproduce it locally and get back to you
> > > >>>
> > > >>> Can you provide a bit more info on how that was triggered btw? I would
> > > >>> be helpful to know
> > > >>>
> > > >>> - OP-TEE version
> > > >>
> > > >> Today's master, 145953d55.
> > > >>
> > > >>> - was it compiled as a module or built-in?
> > > >>
> > > >> Sorry, not sure anymore, switching back and forth right now. I think it
> > > >> was built-in.
> > > >>
> > > >>> - was the supplicant running?
> > > >>
> > > >> Yes.
> > > >>
> > > >
> > > > Ok thanks, that helps.  I guess this also means U-Boot was compiled to
> > > > store the variables in a file in the ESP instead of the RPMB right?
> > > > Otherwise, I can't see how the device booted in the first place.
> > >
> > > U-Boot was not configured to perform secure booting in this case. It had
> > > RPMB support enabled, just didn't have to use it.
> >
> > In your initial mail you said you managed to build a firmware without
> > StMM.  If U-boot isn't reconfigured accordingly -- iow skip the EFI
> > variable storage in an RPMB, the EFI subsystem will fail to start.
> >
> > In any case, I don't think the ooops you are seeing is not connected
> > to this patchset.  Looking at the kernel EFI stub we only set the
> > SetVariableRT if the RTPROP table is set accordingly by the firmware.
> > U-Boot never sets the EFI_RT_SUPPORTED_SET_VARIABLE property since it
> > can't support it.  What you are doing is remount the efivarfs as rw
> > and then trying to set a variable, but the callback for it is  NULL.
> > I think you'll be able to replicate the same behavior on the kernel
> > without even inserting the new module.
> >
>
> I have dropped this series from efi/next for now, given that it
> obviously has problems in its current state.
>
> The risk of merging this now and fixing it later is that it may cause
> regressions for early adopters that rely on the behavior we are
> introducing here. Better to get this in shape first.

The ooops Jan was seeing is reproducible in the current code with
$ sudo mount -o remount,rw /sys/firmware/efi/efivars
$ sudo efi-updatevar -f PK.auth PK

So the only real problem we are discussing here is users having to
remount the efivarfs once the module is inserted and the supplicant is
running right?  We could do something along the lines of the patch
below. That would solve both of the problems.

However, the patch changes the way efivarfs is mounted -- it's now
always mounted as RW.  What I am worried about is userspace tools that
rely on this.  I know fwupd uses it and looks for a RO mounted
efivarfs on it's initial checking, but since userspace apps are
already dealing with firmware that exposes SetVariableRT but always
returns EFI_UNSUPPORTED this should be safe ?(famous last words)

Jan can you please apply this and see if it solves your problem?

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 4cc8d0e7d0fd..37accd9e885c 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -206,6 +206,13 @@ static bool generic_ops_supported(void)
        return true;
 }

+efi_status_t set_variable_int(efi_char16_t *name, efi_guid_t *vendor,
+                             u32 attributes, unsigned long data_size,
+                             void *data)
+{
+       return EFI_UNSUPPORTED;
+}
+
 static int generic_ops_register(void)
 {
        if (!generic_ops_supported())
@@ -219,6 +226,9 @@ static int generic_ops_register(void)
        if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)) {
                generic_ops.set_variable = efi.set_variable;
                generic_ops.set_variable_nonblocking =
efi.set_variable_nonblocking;
+       } else {
+               generic_ops.set_variable = set_variable_int;
+               generic_ops.set_variable_nonblocking = set_variable_int;
        }
        return efivars_register(&generic_efivars, &generic_ops);
 }
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index e9dc7116daf1..c75eff3f409d 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -123,7 +123,7 @@ EXPORT_SYMBOL_GPL(efivars_unregister);

 bool efivar_supports_writes(void)
 {
-       return __efivars && __efivars->ops->set_variable;
+       return __efivars && __efivars->ops->set_variable != set_variable_int;
 }
 EXPORT_SYMBOL_GPL(efivar_supports_writes);

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index e028fafa04f3..e40b5c4c5106 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -242,9 +242,6 @@ static int efivarfs_fill_super(struct super_block
*sb, struct fs_context *fc)
        sb->s_d_op              = &efivarfs_d_ops;
        sb->s_time_gran         = 1;

-       if (!efivar_supports_writes())
-               sb->s_flags |= SB_RDONLY;
-
        inode = efivarfs_get_inode(sb, NULL, S_IFDIR | 0755, 0, true);
        if (!inode)
                return -ENOMEM;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 58d1c271d3b0..ec0ac6ef50a3 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1084,6 +1084,10 @@ int efivars_register(struct efivars *efivars,
                     const struct efivar_operations *ops);
 int efivars_unregister(struct efivars *efivars);

+efi_status_t set_variable_int(efi_char16_t *name, efi_guid_t *vendor,
+                             u32 attributes, unsigned long data_size,
+                             void *data);
+
 void efivars_generic_ops_register(void);
 void efivars_generic_ops_unregister(void);

apalos@hades:~/work/linux-next>;
apalos@hades:~/work/linux-next>git diff
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 4cc8d0e7d0fd..37accd9e885c 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -206,6 +206,13 @@ static bool generic_ops_supported(void)
        return true;
 }

+efi_status_t set_variable_int(efi_char16_t *name, efi_guid_t *vendor,
+                             u32 attributes, unsigned long data_size,
+                             void *data)
+{
+       return EFI_UNSUPPORTED;
+}
+
 static int generic_ops_register(void)
 {
        if (!generic_ops_supported())
@@ -219,6 +226,9 @@ static int generic_ops_register(void)
        if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE)) {
                generic_ops.set_variable = efi.set_variable;
                generic_ops.set_variable_nonblocking =
efi.set_variable_nonblocking;
+       } else {
+               generic_ops.set_variable = set_variable_int;
+               generic_ops.set_variable_nonblocking = set_variable_int;
        }
        return efivars_register(&generic_efivars, &generic_ops);
 }
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index e9dc7116daf1..c75eff3f409d 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -123,7 +123,7 @@ EXPORT_SYMBOL_GPL(efivars_unregister);

 bool efivar_supports_writes(void)
 {
-       return __efivars && __efivars->ops->set_variable;
+       return __efivars && __efivars->ops->set_variable != set_variable_int;
 }
 EXPORT_SYMBOL_GPL(efivar_supports_writes);

diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
index e028fafa04f3..e40b5c4c5106 100644
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -242,9 +242,6 @@ static int efivarfs_fill_super(struct super_block
*sb, struct fs_context *fc)
        sb->s_d_op              = &efivarfs_d_ops;
        sb->s_time_gran         = 1;

-       if (!efivar_supports_writes())
-               sb->s_flags |= SB_RDONLY;
-
        inode = efivarfs_get_inode(sb, NULL, S_IFDIR | 0755, 0, true);
        if (!inode)
                return -ENOMEM;
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 58d1c271d3b0..ec0ac6ef50a3 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1084,6 +1084,10 @@ int efivars_register(struct efivars *efivars,
                     const struct efivar_operations *ops);
 int efivars_unregister(struct efivars *efivars);

+efi_status_t set_variable_int(efi_char16_t *name, efi_guid_t *vendor,
+                             u32 attributes, unsigned long data_size,
+                             void *data);
+
 void efivars_generic_ops_register(void);
 void efivars_generic_ops_unregister(void);

Thanks
/Ilias
