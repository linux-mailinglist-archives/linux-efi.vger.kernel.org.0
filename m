Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63059477C64
	for <lists+linux-efi@lfdr.de>; Thu, 16 Dec 2021 20:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbhLPTXG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Dec 2021 14:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240959AbhLPTWr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Dec 2021 14:22:47 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C18C06173E
        for <linux-efi@vger.kernel.org>; Thu, 16 Dec 2021 11:22:46 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id d21so16990124qkl.3
        for <linux-efi@vger.kernel.org>; Thu, 16 Dec 2021 11:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kOEWdeK+9hlrvRB88Hjdk3F0IQxWtzmHif7o/SL9D9w=;
        b=dZ0nEoslqaFMubZDxQSH1QWv1KL9KP2/0EC7AtBT418/UsfEmE+tEJzTBQeMxdwKEX
         aCje9v/L8R47JJlorq2aW6O5o9pfLrAGFVeNInwwUD1OJoDmfwh8NCdyb2Z84S885DEp
         KkjDq3esYFq6jqF4fh4GW8MzvzzPwcCi/JtMqCpH+k2WujoL7zj5L7U0xq1glfBjYUWq
         30beRvzUfazIaiYFxmQXrjSdXk8zVt8ZGf0fOLvQu0uE8A7cuSz9JrXwveVnjIYyBKOD
         zGFXcLiddIWSktG12kJaIJFsHdY/VRQSpsVrr8gXqmDyMZ6xQrvN3VhZZ36l6sc0aw9V
         Ig8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kOEWdeK+9hlrvRB88Hjdk3F0IQxWtzmHif7o/SL9D9w=;
        b=drl3mk2nLC/rrjzVCJz6E9mvzd1V8F1cmUApdIS/2W+qyDtnRZMJ4RgHuSJycHY/tH
         AKKCfCkk0FqyYJFLAxuq5oip4+AxjM+l4rx9REqm1q9l4XM7ktfJVrzJkSKrtjkmk7CG
         DJPkFztuHj9OSAtb/YK4WRO2rXNTXbjG1Xv6L4lomcaVLU5QMIIdGE+VdKHGixpiA0Ou
         vT0VuZ3MRYmrfaSUBy/64Qtogh0BWhBMhe46CG7+TCupoltI4I3jCrV/2bTT0iFsvhfj
         L/zVcpzN03v+sq/U4T4GRO0VCw2G67o5DQhXyK8xUIOGD2bE51aMr5DPAWueI7TeXsxd
         e19Q==
X-Gm-Message-State: AOAM531LasNtbNa7d6VsZvX1i12lMc4NNpDJsZe+5tzXSsGGMgHtzxWY
        0o/1aEEKoEvvDcxzo7KS0RGwFg==
X-Google-Smtp-Source: ABdhPJw/ErEL8GvHt51bLJ21opV0XNb791PewGduptMSWQtt1hAXZ3FE/QPMLrlHgy8xeJb7vpfdAg==
X-Received: by 2002:a37:6687:: with SMTP id a129mr12887985qkc.295.1639682565905;
        Thu, 16 Dec 2021 11:22:45 -0800 (PST)
Received: from localhost (7-153-16-190.fibertel.com.ar. [190.16.153.7])
        by smtp.gmail.com with ESMTPSA id p12sm4270616qtx.56.2021.12.16.11.22.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 11:22:45 -0800 (PST)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v4 0/5] x86: Show in sysfs if a memory node is able to do encryption
Date:   Thu, 16 Dec 2021 16:22:17 -0300
Message-Id: <20211216192222.127908-1-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
useful for the fwupd usecase, doing it in a per-node basis gives also
the capability to the user to target allocations from applications to
NUMA nodes which have encryption capabilities.


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

Martin Fernandez (5):
  mm/memblock: Tag memblocks with crypto capabilities
  mm/mmzone: Tag pg_data_t with crypto capabilities
  x86/e820: Tag e820_entry with crypto capabilities
  x86/efi: Tag e820_entries as crypto capable from EFI memmap
  drivers/node: Show in sysfs node's crypto capabilities

 Documentation/ABI/testing/sysfs-devices-node | 10 ++++
 arch/x86/include/asm/e820/api.h              |  1 +
 arch/x86/include/asm/e820/types.h            |  1 +
 arch/x86/kernel/e820.c                       | 59 ++++++++++++++++----
 arch/x86/platform/efi/efi.c                  | 26 +++++++++
 drivers/base/node.c                          | 10 ++++
 include/linux/memblock.h                     |  5 ++
 include/linux/mmzone.h                       |  3 +
 mm/memblock.c                                | 49 ++++++++++++++++
 mm/page_alloc.c                              |  1 +
 10 files changed, 153 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-node

-- 
2.30.2

