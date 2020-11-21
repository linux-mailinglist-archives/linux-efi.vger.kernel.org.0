Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA7012BBBD4
	for <lists+linux-efi@lfdr.de>; Sat, 21 Nov 2020 03:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgKUCCo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 20 Nov 2020 21:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgKUCCn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 20 Nov 2020 21:02:43 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AF1C061A47
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:02:43 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id 11so8902310qtx.10
        for <linux-efi@vger.kernel.org>; Fri, 20 Nov 2020 18:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=aGFzMYHBM46OOZ+OXET2qVn4WB5YUaXGBtLD3wqxLn0=;
        b=kGQr00cc01SJ8CKAOyhEXWlNZThwgfkSl+qgQ26wtnx+/j5AvQH16ZLdHa2SSKTxi6
         Wl6jYp2mom/qOF6yQ9aPAZdzRzIDiSjFaD0KqeV4/O2/FMDTWzgBseBN5UhmXGJGG2mJ
         UFGFynvxR+jidkcarG+lfXsx4Y7qr795ZdUhn6YEQSoRH0OEa7BqyjPbisnIAFxTn0jo
         3r+ptTTbuIJ+rgJ/9pG3Y8os7E5ulHZZquGtyWE602mOT4fSDLKoW+j680bu7uJCne/Q
         4SRVXMdl2xl+UFU7RlWwhVlsNyo32n180tZtPZQXyfNRyP0VghMlCoW5v45ydk8t1a02
         92ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=aGFzMYHBM46OOZ+OXET2qVn4WB5YUaXGBtLD3wqxLn0=;
        b=aeUFflmkB9Sk/mEnqnFISLWbuQER+Ll4v8/u9qNZrkHoa7aWCNmyZa6d0Z/4K7PGzK
         QnU4UWPIMMuZDnjpGJwYoGXDaix8l6apFKOLOmAQFxS3DpcWKDSrgzosqqOIS/adZs1m
         6wXf43NgyUzNlIJQr+YjKn5DC5s/KLKk0neQHv6j+zEzOzUw5DSpnrCnW7Z6O/ANtu5U
         keqdY//T4BAkBvwOXSmXKiCEW09TOU4IYJrU2YENSqlqsXXLjIzEdGdvoE2yQ7mJ81ej
         FaoZC40ABOr+di5bLRy5c9JlYdKVwkGVZ8+TZbdec448uMfKlPwLkRhdVBGfr4ZCZn5/
         NVaw==
X-Gm-Message-State: AOAM532ApD/PDpfIR/RDKxr5CIHKDtuyXL+1aDT62hzFdLV+NhrC/HiQ
        7M8TrN1N3BtCAteRT89uY8sjFrUFTVOknxA=
X-Google-Smtp-Source: ABdhPJxL8qJRla81QrWf8gkZNnaRggsmqvW7cimNPJr0EKB7ZLmGeZySPnaseV9m780mti/qCUW9a1i0aqQ2FBw=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a0c:8d4a:: with SMTP id
 s10mr20176485qvb.30.1605924162087; Fri, 20 Nov 2020 18:02:42 -0800 (PST)
Date:   Fri, 20 Nov 2020 18:02:15 -0800
Message-Id: <20201121020232.908850-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 00/17] Refactor fw_devlink to significantly improve boot time
From:   Saravana Kannan <saravanak@google.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        kernel-team@android.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The current implementation of fw_devlink is very inefficient because it
tries to get away without creating fwnode links in the name of saving
memory usage. Past attempts to optimize runtime at the cost of memory
usage were blocked with request for data showing that the optimization
made significant improvement for real world scenarios.

We have those scenarios now. There have been several reports of boot
time increase in the order of seconds in this thread [1]. Several OEMs
and SoC manufacturers have also privately reported significant
(350-400ms) increase in boot time due to all the parsing done by
fw_devlink.

So this patch series refactors fw_devlink to be more efficient. The key
difference now is the addition of support for fwnode links -- just a few
simple APIs. This also allows most of the code to be moved out of
firmware specific (DT mostly) code into driver core.

This brings the following benefits:
- Instead of parsing the device tree multiple times (complexity was
  close to O(N^3) where N in the number of properties) during bootup,
  fw_devlink parses each fwnode node/property only once and creates
  fwnode links. The rest of the fw_devlink code then just looks at these
  fwnode links to do rest of the work.

- Makes it much easier to debug probe issue due to fw_devlink in the
  future. fw_devlink=on blocks the probing of devices if they depend on
  a device that hasn't been added yet. With this refactor, it'll be very
  easy to tell what that device is because we now have a reference to
  the fwnode of the device.

- Much easier to add fw_devlink support to ACPI and other firmware
  types. A refactor to move the common bits from DT specific code to
  driver core was in my TODO list as a prerequisite to adding ACPI
  support to fw_devlink. This series gets that done.

Laurent and Grygorii tested the v1 series and they saw boot time
improvment of about 12 seconds and 3 seconds, respectively.

Thanks,
Saravana

[1] - https://lore.kernel.org/linux-pm/CAGETcx-aiW251dhEXT1GNb9bi6YcX8W=jLBrro5CnPuEjGL09g@mail.gmail.com/

v1 -> v2:
Patches 1-6:
- Added the "why" to explain the reverts.
Patch 7:
- Fixed white space comment.
Patch 8:
- Reworded commit text and some function doc.
Patch 11:
- Fixed the build warning this patch would cause by removing a "const".
Patch 12:
- Added/updated documentation.
- Changed flags from u32 to u8.
Patch 13:
- Squashed with Patch 10. Will use v1 patch number for the rest of the diff
  descriptions.
Patch 15:
- Removed an unnecessary unlikely()
Patch 17:
- Refactored fw_devlink_create_devlink() to flip the error handling vs
  successful paths.
Patch 18:
- Squashed into Patch 17 as requested by Greg.
- Added Tested-by: tags from Laurent and Grygorii.
New Patch 17:
- New patch to delete useless input to add_links()

Saravana Kannan (17):
  Revert "driver core: Avoid deferred probe due to
    fw_devlink_pause/resume()"
  Revert "driver core: Rename dev_links_info.defer_sync to defer_hook"
  Revert "driver core: Don't do deferred probe in parallel with
    kernel_init thread"
  Revert "driver core: Remove check in
    driver_deferred_probe_force_trigger()"
  Revert "of: platform: Batch fwnode parsing when adding all top level
    devices"
  Revert "driver core: fw_devlink: Add support for batching fwnode
    parsing"
  driver core: Add fwnode_init()
  driver core: Add fwnode link support
  driver core: Allow only unprobed consumers for SYNC_STATE_ONLY device
    links
  device property: Add fwnode_is_ancestor_of() and
    fwnode_get_next_parent_dev()
  driver core: Redefine the meaning of fwnode_operations.add_links()
  driver core: Add fw_devlink_parse_fwtree()
  driver core: Use device's fwnode to check if it is waiting for
    suppliers
  of: property: Update implementation of add_links() to create fwnode
    links
  efi: Update implementation of add_links() to create fwnode links
  driver core: Refactor fw_devlink feature
  driver core: Delete pointless parameter in fwnode_operations.add_links

 drivers/acpi/property.c         |   2 +-
 drivers/acpi/scan.c             |   2 +-
 drivers/base/core.c             | 555 ++++++++++++++++++++------------
 drivers/base/property.c         |  52 +++
 drivers/base/swnode.c           |   2 +-
 drivers/firmware/efi/efi-init.c |  32 +-
 drivers/of/dynamic.c            |   1 +
 drivers/of/platform.c           |   2 -
 drivers/of/property.c           | 149 +++------
 include/linux/device.h          |  10 +-
 include/linux/fwnode.h          |  73 ++---
 include/linux/of.h              |   2 +-
 include/linux/property.h        |   3 +
 kernel/irq/irqdomain.c          |   2 +-
 14 files changed, 495 insertions(+), 392 deletions(-)

-- 
2.29.2.454.gaff20da3a2-goog

