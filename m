Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412DE7ADB5B
	for <lists+linux-efi@lfdr.de>; Mon, 25 Sep 2023 17:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjIYPZh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Sep 2023 11:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbjIYPZg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 25 Sep 2023 11:25:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFFFA3
        for <linux-efi@vger.kernel.org>; Mon, 25 Sep 2023 08:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695655481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ErHGI2tx+W7X3lDOKij5J6HSuxHR/AE8g5DA/kexz/Y=;
        b=SG1OXv7+hZ5vE/FgITstLPNjjtaNmTu1dJTFVlZ0Ubz74vQnXHaWzOhGJ+OKSrI184q+FT
        amTfjFDP3Rbs6eWmktSh+lLxydNa4csBPhmjHlTeqqbv8yqFerS7N6xBrAK+5NXWNpqb7L
        KYU1CRFTrhFRk22jX30B6bvazPwsAsI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-lDo9LDuoNxSHHK5gmxEbbg-1; Mon, 25 Sep 2023 11:24:38 -0400
X-MC-Unique: lDo9LDuoNxSHHK5gmxEbbg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4752729AB3FC;
        Mon, 25 Sep 2023 15:24:37 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.192.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CBE02156702;
        Mon, 25 Sep 2023 15:24:34 +0000 (UTC)
Date:   Mon, 25 Sep 2023 17:24:32 +0200
From:   Philipp Rudo <prudo@redhat.com>
To:     Dave Young <dyoung@redhat.com>
Cc:     Jan Hendrik Farr <kernel@jfarr.cc>,
        Pingfan Liu <kernelfans@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        kexec@lists.infradead.org, Pingfan Liu <piliu@redhat.com>,
        Baoquan He <bhe@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, keyrings@vger.kernel.org,
        Luca Boccassi <bluca@debian.org>, lennart@poettering.net,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, mjg59@google.com,
        James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH 0/2] Sign the Image which is zboot's payload
Message-ID: <20230925172432.78b45f80@rotkaeppchen>
In-Reply-To: <CALu+AoQHZOBcbCJJnhSyEcTyX6C3VttLxMKt2mdHgT7A6xHN9w@mail.gmail.com>
References: <20230921133703.39042-1-kernelfans@gmail.com>
        <ZQ0j6Es88aR8cjRv@desktop>
        <CALu+AoQHZOBcbCJJnhSyEcTyX6C3VttLxMKt2mdHgT7A6xHN9w@mail.gmail.com>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Dave,

On Fri, 22 Sep 2023 13:41:22 +0800
Dave Young <dyoung@redhat.com> wrote:

> Hi Jan,
> 
> On Fri, 22 Sept 2023 at 13:19, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
> >
> > Hi Pingfan!
> >
> > On 21 21:37:01, Pingfan Liu wrote:  
> > > From: Pingfan Liu <piliu@redhat.com>
> > >  
> >  
> > > For security boot, the vmlinuz.efi will be signed so UEFI boot loader
> > > can check against it. But at present, there is no signature for kexec
> > > file load, this series makes a signature on the zboot's payload -- Image
> > > before it is compressed. As a result, the kexec-tools parses and
> > > decompresses the Image.gz to get the Image, which has signature and can
> > > be checked against during kexec file load  
> >
> > I missed some of the earlier discussion about this zboot kexec support.
> > So just let me know if I'm missing something here. You were exploring
> > these two options in getting this supported:
> >
> > 1. Making kexec_file_load do all the work.
> >
> > This option makes the signature verification easy. kexec_file_load
> > checks the signature on the pe file and then extracts it and does the
> > kexec.
> >
> > This is similar to how I'm approaching UKI support in [1].
> >
> > 2. Extract in userspace and pass decompressed kernel to kexec_file_load
> >
> > This options requires the decompressed kernel to have a valid signature on
> > it. That's why this patch adds the ability to add that signature to the
> > kernel contained inside the zboot image.
> >
> > This option would not make sense for UKI support as it would not
> > validate the signature with respect to the initrd and cmdline that it
> > contains.  
> 
> Another possibility for the cmdline could be using the bootconfig
> facility which was
> introduced for boot time tracking:
> Documentation/admin-guide/bootconfig.rst
> 
> So the initrd+cmdline can be signed as well.  Has this been discussed
> before for UKI?

Not that I know of. But I'm not sure if the bootconfig the way it works
today does the trick.

For one the bootconfig is simply glued to the end of the initrd. But
that makes it part of the UKI as well. So there is no added gain.

Plus, adding the cmdline to the UKI was done on purpose to prevent any
unauthorized editing. That basically means that any change to the
cmdline needs to be signed as well. But I don't see any signature
verification while processing the bootconfig. 

Finally the bootconfig is setup too late in the boot process,
in particular after setup_arch which reserves the crashkernel
memory and needs to parse the kernel command line for that. An even more
extreme example is the decompressor phase on s390. There the command
line is parsed as well. And that is code that runs before start_kernel.

All in all I don't believe that using the bootconfig adds much benefit
for the UKI.

Thanks
Philipp

