Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037A67AA839
	for <lists+linux-efi@lfdr.de>; Fri, 22 Sep 2023 07:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjIVFTv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 22 Sep 2023 01:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjIVFTv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 22 Sep 2023 01:19:51 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF01192;
        Thu, 21 Sep 2023 22:19:45 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id DF86A5C021D;
        Fri, 22 Sep 2023 01:19:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 22 Sep 2023 01:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jfarr.cc; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1695359981; x=1695446381; bh=sI
        mZwawhrAlSAj9rqR6mD9oRS9gtqddfHemubwEJhpQ=; b=UDpnI/8mmlayVHLf4l
        m4/3gUF7uj7omy6k4ElJUy7kaedsiQK2G+KLjdnJPz5BvxqKX5Zv7UXZ/yAB9gIT
        C8AhvX+rF6zYoK2cQq0hTkuMoimVo2piGEzU8Ex9ldUBbMJuU3hwzNh9pTm3zAGr
        9TtXINNzgKK1UmNE8NdlL+FL8WkVS00xpgdiRIGo9gR1W91I0tH2ZgPPiJ1RQV3a
        FR6x9Q37pL+xgSjcDRh+MtRPI0FMD7Sj1UjP5iFpL91vsea7tjRIx9ICNI/VeRIu
        o5bUJar+5lmDOarTmN8dvFOEIzw66bfF9nTclIRfTbLia3XyZZPxh5WItJ21od0/
        7avA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695359981; x=1695446381; bh=sImZwawhrAlSA
        j9rqR6mD9oRS9gtqddfHemubwEJhpQ=; b=Ca+52/0T1ttXgBWJ149du7KE2simN
        flPwcv7AuBKThqVk3cbbDD4ulrwPqmDQOgVRXV+Q/cKX7cCMxVoZejyzXsi23lOV
        7rglRfNpLcwMKZRwGwQo9txpDKQZpW/QzqfNePgZxkoIzzMfMNUPjDRRI+tJ9CPj
        sEhRFTW9dIWydA6g0bh66V/97F/hSV6AcKa6+5UsoKXTQNnjTwmUPHwmJCK7KrKg
        raQcnEs9dbjxjo8m1T061ZHbzZ+wDZhICzNiwsunec17MszjKU4InXP8dOvjpYML
        ybQhSxFK0txWyAJRQlpVqCdAP9revo3K3sU0O4adCcV+z7wr8Lie8FPXg==
X-ME-Sender: <xms:7SMNZbSKZYdBbPKLuDBcwGe0Rb78gbgTbNPGLvcyjGW89vrVcRrIjA>
    <xme:7SMNZczivx6RZ1a-Wue-RUncrJaSwItjoQqqcqplOj_U2aAkQSwJfsVE7gLaKuPbb
    xPQNEMuVJOFOoOI8n8>
X-ME-Received: <xmr:7SMNZQ0x53Caj-6dCgL0WSHUpz47vB-7yZghDjkeiMGWtzzU2ibesQ8hsopY0PjejJ8ZW7GwwDJ1VXBlyE5ot9OlDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekjedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdluddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddt
    tddvnecuhfhrohhmpeflrghnucfjvghnughrihhkucfhrghrrhcuoehkvghrnhgvlhesjh
    hfrghrrhdrtggtqeenucggtffrrghtthgvrhhnpeehgeefffejveeuleekueeguefftdef
    hefgtedtieeghefhtefgiefhiefhtdetheenucffohhmrghinhepkhgvrhhnvghlrdhorh
    hgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhgv
    rhhnvghlsehjfhgrrhhrrdgttg
X-ME-Proxy: <xmx:7SMNZbD8YIuRD_AooZ6bAE5jgsJAsZUYkFBlqVy-y2u_JPeGHHg0Bw>
    <xmx:7SMNZUh71Uk48BslAAQw-dkeZ6UrzSexw4yb1Tp2WwCp5u1x14QHvg>
    <xmx:7SMNZfrJ7tM1-HQRbxW7EH-oXOoo6Udc79IBAEVQr3KIOlBPQzcE5w>
    <xmx:7SMNZdZ9IB3bBaTU5JbU9kDaqqLPemtOSuHUowrJlD7h9jdnKXFrmw>
Feedback-ID: i01d149f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Sep 2023 01:19:39 -0400 (EDT)
Date:   Fri, 22 Sep 2023 07:19:36 +0200
From:   Jan Hendrik Farr <kernel@jfarr.cc>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        kexec@lists.infradead.org, Pingfan Liu <piliu@redhat.com>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Philipp Rudo <prudo@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, keyrings@vger.kernel.org,
        Luca Boccassi <bluca@debian.org>, lennart@poettering.net,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, mjg59@google.com,
        James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH 0/2] Sign the Image which is zboot's payload
Message-ID: <ZQ0j6Es88aR8cjRv@desktop>
References: <20230921133703.39042-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921133703.39042-1-kernelfans@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Pingfan!

On 21 21:37:01, Pingfan Liu wrote:
> From: Pingfan Liu <piliu@redhat.com>
> 

> For security boot, the vmlinuz.efi will be signed so UEFI boot loader
> can check against it. But at present, there is no signature for kexec
> file load, this series makes a signature on the zboot's payload -- Image
> before it is compressed. As a result, the kexec-tools parses and
> decompresses the Image.gz to get the Image, which has signature and can
> be checked against during kexec file load

I missed some of the earlier discussion about this zboot kexec support.
So just let me know if I'm missing something here. You were exploring
these two options in getting this supported:

1. Making kexec_file_load do all the work.

This option makes the signature verification easy. kexec_file_load
checks the signature on the pe file and then extracts it and does the
kexec.

This is similar to how I'm approaching UKI support in [1].

2. Extract in userspace and pass decompressed kernel to kexec_file_load

This options requires the decompressed kernel to have a valid signature on
it. That's why this patch adds the ability to add that signature to the
kernel contained inside the zboot image.

This option would not make sense for UKI support as it would not
validate the signature with respect to the initrd and cmdline that it
contains. Am I correct in thinking that there is no similar issue with
zboot images? They don't contain any more information besides the kernel
that is intended to be securely signed, right? Do you have a reference
for the zboot image layout somewhere?

> I hesitate to post this series, 

I appreciate you sending it, it's helping the discussion along.

> [...] since Ard has recommended using an
> emulated UEFI boot service to resolve the UKI kexec load problem [1].
> since on aarch64, vmlinuz.efi has faced the similar issue at present.
> But anyway, I have a crude outline of it and am sending it out for
> discussion.

The more I'm thinking about it, the more I like Ard's idea. There's now
already two different formats trying to be added to kexec that are
pretty different from each other, yet they both have the UEFI interface
in common. I think if the kernel supported kexec'ing EFI applications
that would be a more flexible and forward-looking approach. It's a
standard that both zboot and UKI as well as all future formats for UEFI
platforms will support anyways. So while it's more work right now to
implement, I think it'll likely pay off.

It is significantly more work than the other options though. So I think
before work is started on it, it would be nice to get some type of
consensus on these things (not an exhaustive list, please feel free to
add to it):

1. Is it the right approach? It adds a significant amount of userspace
API.
2. What subset of the UEFI spec needs/should to be supported?
3. Can we let runtime services still be handled by the firmware after
exiting boot services?
4. How can we debug the stubs that are being invoked?
5. Can we let the EFI binary know that this is a kexec and not a normal
bootup. Potentially systemd-stub would want to change how/if it does TPM
PCR measurements.
...


[1] https://lore.kernel.org/kexec/20230911052535.335770-2-kernel@jfarr.cc/T/

Added some more CCs.

