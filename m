Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA1175671C
	for <lists+linux-efi@lfdr.de>; Mon, 17 Jul 2023 17:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjGQPER (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 17 Jul 2023 11:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjGQPEO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 17 Jul 2023 11:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2797C10DF
        for <linux-efi@vger.kernel.org>; Mon, 17 Jul 2023 08:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689606211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SiBMrn+7osyMXo/+tKE4pG92GpAUpq53+LvmvO3TmV8=;
        b=B3gwAWhqNax7cwk7/TLmqUuFEzeHn+oJzpaYz4B9CyP/pxJDHj5g9Y6xyY31TWlup8oH/s
        jxYgaO70B8SaUr4H/8vDlPHWjcdn+mmS65kbL+q3KPb6iSwEtUghBXV0OBBMqVRN2jFnhI
        dTf89GvjahSqFc4lc8m286TiENQ+Nio=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-dYHMtGS-Ps-nOHxrgXx62A-1; Mon, 17 Jul 2023 11:03:21 -0400
X-MC-Unique: dYHMtGS-Ps-nOHxrgXx62A-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-51e10b6148cso5501135a12.1
        for <linux-efi@vger.kernel.org>; Mon, 17 Jul 2023 08:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689606200; x=1692198200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiBMrn+7osyMXo/+tKE4pG92GpAUpq53+LvmvO3TmV8=;
        b=Wm1xbxOk1VKmB4RHQO5wORNXSTr8uZroiCZLVSX4mk2IvBzviheIheam+KGYqCsxoY
         n3hm2LHX/8TRQiegF3TWjD18fFJrZGXSieJFGVObePMy54HMMaZtXAQEYbuVT5nQYXVQ
         rMgx3rHe6xo8uWWxvk6oMLcFLC5vCSKdbNAJKJ6NuXC8YI5k4hhxgnLcmHzGFp5/CMC9
         bSFMmqK2sEK3VqAIKFJEbn8wIQAsJCHL8oR28/mWdD8dCHDV6U7locwYawn7m5hn958N
         WeOKCsxkXB4b4o96gpwJ9xjSalHLaXGIsrRCBdOR7NzBoZXVPVOnt2Ydj4dDk8R4GSeS
         kTLQ==
X-Gm-Message-State: ABy/qLacT2e9w4wqk8but+3Kv0qHWvIxqkZzCh4qwvWGBtFv/MCtzaGP
        bI+n1fodlQqU0O1MG2pj2fKSBB5gxWnryo9Mrf7WLE4w6txuXQZ04P7jX5Zr421OF98/Jw2PH/b
        Vb/zLPrZvVg4ukiEagGKlNURtbWsMnCYnEJ2M
X-Received: by 2002:a05:6402:104f:b0:521:985d:7314 with SMTP id e15-20020a056402104f00b00521985d7314mr2171134edu.18.1689606199889;
        Mon, 17 Jul 2023 08:03:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEoeC3xa/5aQjDsGItXISa8YGqmN7zj10ELFkhg1xaPxRBxx//hSueafi0Wxze1pAe8Q8cX3fxzgZYOQ+L/pNo=
X-Received: by 2002:a05:6402:104f:b0:521:985d:7314 with SMTP id
 e15-20020a056402104f00b00521985d7314mr2171100edu.18.1689606199599; Mon, 17
 Jul 2023 08:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230601072043.24439-1-ltao@redhat.com> <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
 <CAO7dBbXdJgpO4Ym=4WME3OOrUhq2MNKpNZmhpsC7pOSugHiKDg@mail.gmail.com>
 <ZKeTX2aemPbsMiVr@MiWiFi-R3L-srv> <ZKfLYG_4DANc_i5r@suse.de>
 <20230707085712.GBZKfTaGJXnzhEenxj@fat_crate.local> <20230707152515.42gpfzjgvfwe6rf7@amd.com>
 <20230707171217.GHZKhHcffp4nn6RgR/@fat_crate.local> <CAMj1kXFBtd6DRzwNbuY5_zc4DThjQWs9itN=qYkED-+6nkoGcw@mail.gmail.com>
In-Reply-To: <CAMj1kXFBtd6DRzwNbuY5_zc4DThjQWs9itN=qYkED-+6nkoGcw@mail.gmail.com>
From:   Tao Liu <ltao@redhat.com>
Date:   Mon, 17 Jul 2023 23:02:43 +0800
Message-ID: <CAO7dBbW8pAP9PsBBu+ywygc_RivX4t0yBNOa+aDkyBWA9HECjg@mail.gmail.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Baoquan He <bhe@redhat.com>,
        thomas.lendacky@amd.com, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

Thanks for your explanation!

On Thu, Jul 13, 2023 at 6:18=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Fri, 7 Jul 2023 at 19:12, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Fri, Jul 07, 2023 at 10:25:15AM -0500, Michael Roth wrote:
> > > ...
> > > It would be unfortunate if we finally abandoned this path because of =
the
> > > issue being hit here though. I think the patch posted here is the pro=
per
> > > resolution to the issue being hit, and I'm hoping at this point we've
> > > identified all the similar cases where EFI/setup_data-related structu=
res
> > > were missing explicit mappings. But if we still think it's too much o=
f a
> > > liability to access the EFI config table outside of SEV-enabled guest=
s,
> > > then I can work on re-implementing things based on the above logic.
> >
> > Replying here to Tom's note too...
> >
> > So, I like the idea of rechecking CPUID. Yes, let's do the sev_status
> > check. As a result, we either fail the guest - no problem - or we boot
> > and we recheck. Thus, we don't run AMD code on !AMD machines, if the HV
> > is not a lying bastard.
> >
> > Now, if we've gotten a valid setup_data SETUP_EFI entry with a valid
> > pointer to an EFI config table, then that should happen in the generic
> > path - initialize_identity_maps(), for example - like you've done in
> > b57feed2cc26 - not in the kexec code because kexec *happens* to need it=
.
> >
> > We want to access the EFI config table? Sure, by all means, but make
> > that generic for all code.
> >
>
> OK, so in summary, what seems to be happening here is that the SEV
> init code in the decompressor looks for the cc blob table before the
> on-demand mapping code is up, which normally ensures that any RAM
> address is accessible even if it hasn't been mapped explicitly.
>
Yes it is exactly the case.

> This is why the fix happens to work: the code only maps the array of
> (guid, phys_addr) tuples that describes the list of configuration
> tables that have been provided by the firmware. The actual
> configuration tables themselves could be anywhere in physical memory,
> and without prior knowledge of a particular GUID value, there is no
> way to know the size of the table, and so they cannot be mapped

Should we loop map each element of the config table one at a time? We
read a GUID value, then we map it with phys_addr, phys_addr +
sizeof(struct), then we read-map the next one, in this way we may not
need to know the size of the table?

> upfront like this. However, the cc blob table does not exist on this
> machine, and so whether the EFI config tables themselves are mapped or
> not is irrelevant.

Currently we don't need all the data of the config table, only part of
it. So only  (guid, phys_addr) tuple arrays are mapped into. Won't it
be better if we map config table on demand if we need further data
later?

>
> But it does mean the fix is incomplete, and certainly does not belong
> in generic kexec code. If anything, we should be fixing the
> decompressor code to defer the cc blob table check until after the
> demand mapping code is up.

Yes, if we can defer the cc blob access, the issue can be resolved. I
don't know if it is doable from AMD's view...
>
> If this is problematic, we might instead disable SEV for kexec, and
> rely on the fact that SEV firmware enters with a complete 1:1 map (as

We still need sev support for kexec. If we disable sev during kexec, I
suppose kdump may be broken on a sev guest, maybe?

Thanks,
Tao Liu

> we seem to be doing currently). If kexec for SEV is needed at some
> point, we can re-enable it by having it provide a mapping for the
> config table array and the cc blob table explicitly.
>

