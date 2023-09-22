Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C7D7AA879
	for <lists+linux-efi@lfdr.de>; Fri, 22 Sep 2023 07:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjIVFmu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 Sep 2023 01:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjIVFmq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 22 Sep 2023 01:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD64196
        for <linux-efi@vger.kernel.org>; Thu, 21 Sep 2023 22:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695361305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w1g43mhqJbkov4+o/9sy0UqgCm25IRVOc1Rtq6HxOfs=;
        b=G2a7hJtdT1Zmg2kssnMFECANZGZRumtzyMJTfbvXymZAVlQOMaf2H0B9Cdig7Z+DAzBIl3
        mH+z5ofb2VU1aiSardBQm5/Qj7KP92J0mqaaHl9UUTUIMhTs2xosBJT53o2HTsrj8xbisa
        sj316T3/qFlXUPBNB8kNIaHcw/TPUUk=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-YxCFiX7JMlK5ldY_YeN81A-1; Fri, 22 Sep 2023 01:41:43 -0400
X-MC-Unique: YxCFiX7JMlK5ldY_YeN81A-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-79f7a3e5dd2so40447039f.0
        for <linux-efi@vger.kernel.org>; Thu, 21 Sep 2023 22:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695361302; x=1695966102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w1g43mhqJbkov4+o/9sy0UqgCm25IRVOc1Rtq6HxOfs=;
        b=CSpRumK86mop9TvWQabVEgkKO0zB/Y5LZ/QQ8+39kcn1dLCUofNxCehdDPS1QTUHk/
         44WIyt8dFT0pazWtKp39E8qSU5nC3VQTyCN6u1xBlGHXlawomuD+x+OPkUvSqhqEoq2P
         0qW5NtTsYvcWA1gV3KaEJng9KemOiijb57sJsyoveEjsGyn8V1akx+HO7G947/ouId74
         WapvD1nPqDam9i+ilSES2BB6o6Plk//m36ZvqHAokHgNFr82pvj8C5IzdIm6uM1enAxM
         exctrNH67vycNYnqkCbrAuRMx+31X5eqQcJUIAWHvbwBV6Gw45QIHOISxJTm4FuQpYrK
         GMRA==
X-Gm-Message-State: AOJu0YxRVdcP8IOTPAumxDaF6LjSFbEuafiYMH4yJds3vpwmH6SFCQS/
        4TZMK+iCj9pf6j1s9Vo6G7x4spotrU8zvlEF01NuhDstuZAFsRnZRj2Xtpi0bb6jzU9/bb+Ziu3
        6UDSiJubSBb3sXyzO8MjBgEpJlLqkLrYttLe9
X-Received: by 2002:a05:6e02:78e:b0:34e:2a69:883c with SMTP id q14-20020a056e02078e00b0034e2a69883cmr8337984ils.1.1695361302706;
        Thu, 21 Sep 2023 22:41:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7U4ewOt9pYuaiF1z9N4YP0emAqNw0+efBuWJO/E+lbDyczzOUW+FIWgqK+FH1Y4BNMPXHNG22j7U9dWvcSwI=
X-Received: by 2002:a05:6e02:78e:b0:34e:2a69:883c with SMTP id
 q14-20020a056e02078e00b0034e2a69883cmr8337962ils.1.1695361302436; Thu, 21 Sep
 2023 22:41:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230921133703.39042-1-kernelfans@gmail.com> <ZQ0j6Es88aR8cjRv@desktop>
In-Reply-To: <ZQ0j6Es88aR8cjRv@desktop>
From:   Dave Young <dyoung@redhat.com>
Date:   Fri, 22 Sep 2023 13:41:22 +0800
Message-ID: <CALu+AoQHZOBcbCJJnhSyEcTyX6C3VttLxMKt2mdHgT7A6xHN9w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Sign the Image which is zboot's payload
To:     Jan Hendrik Farr <kernel@jfarr.cc>
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        kexec@lists.infradead.org, Pingfan Liu <piliu@redhat.com>,
        Baoquan He <bhe@redhat.com>, Philipp Rudo <prudo@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, keyrings@vger.kernel.org,
        Luca Boccassi <bluca@debian.org>, lennart@poettering.net,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, mjg59@google.com,
        James.Bottomley@hansenpartnership.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Jan,

On Fri, 22 Sept 2023 at 13:19, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
>
> Hi Pingfan!
>
> On 21 21:37:01, Pingfan Liu wrote:
> > From: Pingfan Liu <piliu@redhat.com>
> >
>
> > For security boot, the vmlinuz.efi will be signed so UEFI boot loader
> > can check against it. But at present, there is no signature for kexec
> > file load, this series makes a signature on the zboot's payload -- Image
> > before it is compressed. As a result, the kexec-tools parses and
> > decompresses the Image.gz to get the Image, which has signature and can
> > be checked against during kexec file load
>
> I missed some of the earlier discussion about this zboot kexec support.
> So just let me know if I'm missing something here. You were exploring
> these two options in getting this supported:
>
> 1. Making kexec_file_load do all the work.
>
> This option makes the signature verification easy. kexec_file_load
> checks the signature on the pe file and then extracts it and does the
> kexec.
>
> This is similar to how I'm approaching UKI support in [1].
>
> 2. Extract in userspace and pass decompressed kernel to kexec_file_load
>
> This options requires the decompressed kernel to have a valid signature on
> it. That's why this patch adds the ability to add that signature to the
> kernel contained inside the zboot image.
>
> This option would not make sense for UKI support as it would not
> validate the signature with respect to the initrd and cmdline that it
> contains.

Another possibility for the cmdline could be using the bootconfig
facility which was
introduced for boot time tracking:
Documentation/admin-guide/bootconfig.rst

So the initrd+cmdline can be signed as well.  Has this been discussed
before for UKI?

Thanks
Dave

