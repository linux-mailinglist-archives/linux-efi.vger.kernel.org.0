Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3925C6519BF
	for <lists+linux-efi@lfdr.de>; Tue, 20 Dec 2022 04:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiLTDpW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Dec 2022 22:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiLTDpV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Dec 2022 22:45:21 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C272F6314
        for <linux-efi@vger.kernel.org>; Mon, 19 Dec 2022 19:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671507872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=JMP7GmVXqguUF7MM/7mF5ihfNVruO5OR2h0REJJfmCg=;
        b=WY0UroPKtOikfWtul5zy5BDk+kbzWgxaEpT8R1KrZtFK0JejC2gmxQfb9V3FcosUX75Pm3
        RuyDkZG3mRuQzlDBpkZtuBbmH1YdZZ39UzLNypBipLBiSp8AzKxrxjFbxrsnMOekAKjuDw
        I651TFDClT5SJoj5MFy+b7J4NgcCISA=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-222-vVLXccNTPt6gLhra-3yUxQ-1; Mon, 19 Dec 2022 22:44:31 -0500
X-MC-Unique: vVLXccNTPt6gLhra-3yUxQ-1
Received: by mail-oo1-f71.google.com with SMTP id j2-20020a4a7502000000b0049bdd099de9so5143498ooc.0
        for <linux-efi@vger.kernel.org>; Mon, 19 Dec 2022 19:44:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JMP7GmVXqguUF7MM/7mF5ihfNVruO5OR2h0REJJfmCg=;
        b=ofcuZcZxm8bxwdx1KFu232sB9bFXE1SMMm6Em2cSfebZ7UX3YDf9PRVGULX8KbAFfy
         58PQvs5+dHYIVJN/31xRCS1g2SzbEag5dt9aurxWlsHt0m4Y3FezimxP/NV6R7md0u/7
         uIm88fNO2tHgoYYcvAgwjHVeIu/rzlwn2eAegYdKhpBCX4dpLDNb8QqJzKTLna5/1Hhh
         9CGbOjNaeq4b8l8srwYqsXtlIwj+wfU+ICh0N3/H81+RFudEqbc0yrTNN2aLZ9t3tQFb
         5cIyagWMEU5bUfw9WGoqJiIDg+wpH6zB36vZ2bF2i39BD4KtS5TThqh5Dot3yTCkCm4V
         zIZA==
X-Gm-Message-State: ANoB5pnKnVI6UHgfZTyz6CtYywcCis36qzYqQ1NDNUX7EfszU6y08owE
        Uv7ceJtAWlGQqlc/sBgXSECbwYm3mj/VFaEmnRi67IT1T5jwcGOABFXRqJmi2Zwb1N5GGhkRe3y
        rTTSCedL+++oZJw3KC3jypggXHohI1T3hl+KD
X-Received: by 2002:a05:6808:299:b0:35b:cd76:c89a with SMTP id z25-20020a056808029900b0035bcd76c89amr1048167oic.175.1671507870521;
        Mon, 19 Dec 2022 19:44:30 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6wOjsIgRV8XdpZaGCSR90XiEfn3gsdCjSKLgA/iC/frXoA+X2VmWsyldmUOclHAB63Ad9njReCnaqtlorE1wU=
X-Received: by 2002:a05:6808:299:b0:35b:cd76:c89a with SMTP id
 z25-20020a056808029900b0035bcd76c89amr1048164oic.175.1671507870376; Mon, 19
 Dec 2022 19:44:30 -0800 (PST)
MIME-Version: 1.0
From:   Dave Young <dyoung@redhat.com>
Date:   Tue, 20 Dec 2022 11:43:23 +0800
Message-ID: <CALu+AoSXOCJPH0edbb-BmyTz2zUywY8-QfjYjjKJggSTmK=WyQ@mail.gmail.com>
Subject: Queries about disabling EFI runtime services late
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Coiby Xu <coxu@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

Real time kernels usually disable efi runtime for latency issues, but
for some use cases, e.g. when Secure Boot is used kexec needs to get
the UEFI keys to verify the kernel signatures with kexec_file_load
syscall.

Do you have suggestions on how to make both work?
Is it possible to have something like CONFIG_EFI_DISABLE_RUNTIME_LATE
so the runtime can be disabled after init phase or a runtime switch in sysctl?

Thanks
Dave

