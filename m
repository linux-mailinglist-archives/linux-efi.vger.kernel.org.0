Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9BC50E6A8
	for <lists+linux-efi@lfdr.de>; Mon, 25 Apr 2022 19:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiDYRS5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Apr 2022 13:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243886AbiDYRSs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 25 Apr 2022 13:18:48 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A80627CDE
        for <linux-efi@vger.kernel.org>; Mon, 25 Apr 2022 10:15:40 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-e2fa360f6dso16773521fac.2
        for <linux-efi@vger.kernel.org>; Mon, 25 Apr 2022 10:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xAqFGp4hJ4Ap2PuQylwdDGIE1QUHHxK7SjRFz0bwo5Q=;
        b=AsoXTo3P/v11xpcJVVh/+rUNJq0+W6ckgtZK9u6NRoKvlpEBLIYBE9zc7aMdV1ssFe
         /ZUXgNoyFA4tPC9YhlNWm1EeAYT8weVVmIATUa040wYMKoRqAlHEV1y8KwMlhBicE00Y
         j0bV3883YlB1dhcY1uH7ooaN4TT68YzZcAJ+a74nP/ZSjr/MmPzwJwTPBbJhp1fE/hv3
         4zA8YwAPaDCgtKQey8lqdGlyV24RFMGMmiI0ym8yQygCOkL5ZS8LNWsYxQ4enLJ5UkVi
         dy+VLSfRUze333U9gYZx56jdwapBkuWTXLBhyiWKjtfE+uQTRcisjM65D3/U2QpwyuOr
         YvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xAqFGp4hJ4Ap2PuQylwdDGIE1QUHHxK7SjRFz0bwo5Q=;
        b=dG3geOu3AsxDOBkBJEsTlJOPd6/Q2y82Pv/tZVRbdubNZ1FhADxdcBVhjQT0i/rGRy
         MUy2wqQAc8xYzOm4DP1Smka0EtmPkSEGZTwt8sVAs7e+DQdXCbnUmMgoG7Y0UxOkX1NC
         D4kn7gM8uJZ6mPDhzBM8hRWSRKIaHpvPem56ptUO91IWkzTcoOjWxB6bG9M/wWqSOiIb
         MplwPYkGuhalDthemLKgmybXvCN6ROXNkLM42umwo/4XT+ZIDruucooItwqLfyoAnyH4
         wHbf7CsxvhkH3FFpaF8ACz8HMRzWOQS4x3Cvfba3tnZ/kd+BLyN0dj9OE5GcilH71Bwz
         my1w==
X-Gm-Message-State: AOAM530eJItrmaYxm5nmwaKtfzKA8U4bohl9e2FfeqxNfs+Y+nmfybU+
        /xf2dbH9wNkSlexeOfBL0M/r8Q==
X-Google-Smtp-Source: ABdhPJwIqHsRndbjajjZz2J3odU4hYOVsQeCXFIT0F5+eEMWut+Rj0fsSl1OZvEZqluy0EMsZCJQnQ==
X-Received: by 2002:a05:6870:f697:b0:da:b3f:3268 with SMTP id el23-20020a056870f69700b000da0b3f3268mr7594160oab.280.1650906939567;
        Mon, 25 Apr 2022 10:15:39 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id b188-20020aca34c5000000b002da579c994dsm3886992oia.31.2022.04.25.10.15.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 10:15:39 -0700 (PDT)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v7 0/8] x86: Show in sysfs if a memory node is able to do encryption
Date:   Mon, 25 Apr 2022 14:15:18 -0300
Message-Id: <20220425171526.44925-1-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Show for each node if every memory descriptor in that node has the
EFI_MEMORY_CPU_CRYPTO attribute.

fwupd project plans to use it as part of a check to see if the users
have properly configured memory hardware encryption
capabilities. fwupd's people have seen cases where it seems like there
is memory encryption because all the hardware is capable of doing it,
but on a closer look there is not, either because of system firmware
or because some component requires updating to enable the feature.

It's planned to make it part of a specification that can be passed to
people purchasing hardware

These checks will run at every boot. The specification is called Host
Security ID: https://fwupd.github.io/libfwupdplugin/hsi.html.

We choosed to do it a per-node basis because although an ABI that
shows that the whole system memory is capable of encryption would be
useful for the fwupd use case, doing it in a per-node basis gives also
the capability to the user to target allocations from applications to
NUMA nodes which have encryption capabilities.

I did some tests for some of the functions introduced (and modified)
in e820.c. Sadly KUnit is not able to test __init functions and data
so I had some warnings during the linking. There is a KUnit patch
already to fix that [1]. I wanted to wait for it to be merged but it
is taking more time than I expected so I'm sending this without tests
for now.

[1] https://lore.kernel.org/lkml/20220419040515.43693-1-brendanhiggins@google.com/T/


Changes since v6:

Fixes in __e820__handle_range_update

Const correctness in e820.c

Correct alignment in memblock.h

Rework memblock_overlaps_region


Changes since v5:

Refactor e820__range_{update, remove, set_crypto_capable} in order to
avoid code duplication.

Warn the user when a node has both encryptable and non-encryptable
regions.

Check that e820_table has enough size to store both current e820_table
and EFI memmap.


Changes since v4:

Add enum to represent the cryptographic capabilities in e820:
e820_crypto_capabilities.

Revert __e820__range_update, only adding the new argument for
__e820__range_add about crypto capabilities.

Add a function __e820__range_update_crypto similar to
__e820__range_update but to only update this new field.


Changes since v3:

Update date in Doc/ABI file.

More information about the fwupd usecase and the rationale behind
doing it in a per-NUMA-node.


Changes since v2:

e820__range_mark_crypto -> e820__range_mark_crypto_capable.

In e820__range_remove: Create a region with crypto capabilities
instead of creating one without it and then mark it.


Changes since v1:

Modify __e820__range_update to update the crypto capabilities of a
range; now this function will change the crypto capability of a range
if it's called with the same old_type and new_type. Rework
efi_mark_e820_regions_as_crypto_capable based on this.

Update do_add_efi_memmap to mark the regions as it creates them.

Change the type of crypto_capable in e820_entry from bool to u8.

Fix e820__update_table changes.

Remove memblock_add_crypto_capable. Now you have to add the region and
mark it then.

Better place for crypto_capable in pglist_data.

Martin Fernandez (8):
  mm/memblock: Tag memblocks with crypto capabilities
  mm/mmzone: Tag pg_data_t with crypto capabilities
  x86/e820: Add infrastructure to refactor e820__range_{update,remove}
  x86/e820: Refactor __e820__range_update
  x86/e820: Refactor e820__range_remove
  x86/e820: Tag e820_entry with crypto capabilities
  x86/efi: Mark e820_entries as crypto capable from EFI memmap
  drivers/node: Show in sysfs node's crypto capabilities

 Documentation/ABI/testing/sysfs-devices-node |  10 +
 arch/x86/include/asm/e820/api.h              |   1 +
 arch/x86/include/asm/e820/types.h            |  12 +-
 arch/x86/kernel/e820.c                       | 481 +++++++++++++++----
 arch/x86/platform/efi/efi.c                  |  37 ++
 drivers/base/node.c                          |  10 +
 include/linux/memblock.h                     |   5 +
 include/linux/mmzone.h                       |   3 +
 mm/memblock.c                                |  62 +++
 mm/page_alloc.c                              |   1 +
 10 files changed, 524 insertions(+), 98 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-node

-- 
2.30.2

