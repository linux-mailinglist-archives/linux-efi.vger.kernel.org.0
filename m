Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FA57A9ED5
	for <lists+linux-efi@lfdr.de>; Thu, 21 Sep 2023 22:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjIUUNN (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 21 Sep 2023 16:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjIUUNB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 21 Sep 2023 16:13:01 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7804F58C10
        for <linux-efi@vger.kernel.org>; Thu, 21 Sep 2023 10:28:26 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68fb98745c1so964272b3a.1
        for <linux-efi@vger.kernel.org>; Thu, 21 Sep 2023 10:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695317305; x=1695922105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s3PFsk9RxawxfMXOtaSCxuM4N0nVN4fYpqcnCn3pjAc=;
        b=lBK7XmEYpPIyrxRtQDhUHLbh4Tmb0jNbm5c2xzpZrNBGfB7OMciZGvHvaxByhFJQuI
         q45MoK61w1INInaJBzz/A9Twexl3UJOrzWGzsogkfHjgV/c04MMWpkqA44NMwhBrs88s
         jrtPXEFAzsk4VEebkiWegF6P5O9tLMqeOGVxPrJ4a6UA184s+Y8Jpdzbg+dr14qEgcXS
         RTP41UZg1Tk9O9cMRwVmNK05rL0X4x8qUV75+17C/tddazG3prwXwrWN2HdFL21vjziI
         iETuuAXwOk0a3eqcpggj+bGVtS/Lz4LxK5MUlUEBVW01rZt29tWffTTufPIkBA4nbL9o
         gYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695317305; x=1695922105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s3PFsk9RxawxfMXOtaSCxuM4N0nVN4fYpqcnCn3pjAc=;
        b=WE6U9L1M3N5CYw0PveVOyfe1EVCLn8hAz2L3WtoNwRouYl1hyef0yvgLv9nsbzyXN/
         d3yiFc4uFi4ZDBWOb0bRxGgy+n0TLHMCzlkDBWfzEU7rYpluaBIxP04U2HFy8ICY7tHj
         vvwwNkxV0kOF/pO1l/EzLzy4nfrq4KP+zoFp217GRwZ+ZdS5D208ysZ+7yIPohyrrnnQ
         M3KT1yQxTyNPYukgYUk4gQMdlM19DsAA2A9jqoR3haERprQDcxFSVx5DnxXk2RW1JKzu
         9UqAzcTY5g92jDZEaFpieSZLAqq97jwvXzghGlYGb6ZWDg7ys6oykMq0h+yu1JIbuRP6
         p9VQ==
X-Gm-Message-State: AOJu0YwUzXUJgB96veFp5e7i/3SWg38IWiVTPVkHIFUivsZqu9wrjltU
        ik7Ck/q7wg8VWgCD1PSyklHvlrTtVzGf
X-Google-Smtp-Source: AGHT+IHqBOWg1F4PKaT/rGEtmyVHAKj64PV6vA12DXK8x2GnhLUghr0fvSUmo/QuxpPBpHJLSaljVg==
X-Received: by 2002:a05:6a20:3d91:b0:14c:a53c:498c with SMTP id s17-20020a056a203d9100b0014ca53c498cmr6514454pzi.10.1695303443117;
        Thu, 21 Sep 2023 06:37:23 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d24-20020aa78158000000b00690188b124esm1389785pfn.174.2023.09.21.06.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 06:37:22 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        kexec@lists.infradead.org
Cc:     Pingfan Liu <piliu@redhat.com>,
        "Jan Hendrik Farr" <kernel@jfarr.cc>,
        "Baoquan He" <bhe@redhat.com>, "Dave Young" <dyoung@redhat.com>,
        "Philipp Rudo" <prudo@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 0/2] Sign the Image which is zboot's payload
Date:   Thu, 21 Sep 2023 21:37:01 +0800
Message-Id: <20230921133703.39042-1-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

From: Pingfan Liu <piliu@redhat.com>

I hesitate to post this series, since Ard has recommended using an
emulated UEFI boot service to resolve the UKI kexec load problem [1].
since on aarch64, vmlinuz.efi has faced the similar issue at present.
But anyway, I have a crude outline of it and am sending it out for
discussion.

For security boot, the vmlinuz.efi will be signed so UEFI boot loader
can check against it. But at present, there is no signature for kexec
file load, this series makes a signature on the zboot's payload -- Image
before it is compressed. As a result, the kexec-tools parses and
decompresses the Image.gz to get the Image, which has signature and can
be checked against during kexec file load

[1]: https://lore.kernel.org/lkml/20230918173607.421d2616@rotkaeppchen/T/#mc60aa591cb7616ceb39e1c98f352383f9ba6e985

Cc: "Ard Biesheuvel <ardb@kernel.org>"
Cc: "Jan Hendrik Farr" <kernel@jfarr.cc>
Cc: "Baoquan He" <bhe@redhat.com>
Cc: "Dave Young" <dyoung@redhat.com>
Cc: "Philipp Rudo" <prudo@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org
To: linux-efi@vger.kernel.org
To: kexec@lists.infradead.org


Pingfan Liu (2):
  zboot: Signing the payload
  arm64: Enable signing on the kernel image loaded by kexec file load

 arch/arm64/Kconfig                          |  2 +
 drivers/firmware/efi/libstub/Makefile.zboot | 23 +++++++--
 kernel/Kconfig.kexec_sign                   | 54 +++++++++++++++++++++
 3 files changed, 76 insertions(+), 3 deletions(-)
 create mode 100644 kernel/Kconfig.kexec_sign

-- 
2.31.1

