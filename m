Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA804118725
	for <lists+linux-efi@lfdr.de>; Tue, 10 Dec 2019 12:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfLJLvc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Dec 2019 06:51:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45297 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727419AbfLJLvb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Dec 2019 06:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575978690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bwaQi+22G1RQuMWOfXV/Ab6nGpIMmUXmK6Qhicz5k78=;
        b=d6ml7CIL724nbf7bVbrIVrGyofsxqM2FXAH3fWjL6DeegmzSC1m4EubSn1eaP4Anvt8VyP
        Nq3uA6N4w4WKtyG6CAaVGfqTYJCYq+v5v4vrbS7fwD4Bl67+F+CH7ZLzxBLMYLWbFzV/71
        9WZX+MzpQLc+B62l7GfvDX6C3BoPh7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-N3aFnNSYPpC2h3oQ9fY4YA-1; Tue, 10 Dec 2019 06:51:27 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F945802564;
        Tue, 10 Dec 2019 11:51:24 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEE0A5DA2C;
        Tue, 10 Dec 2019 11:51:18 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v10 00/10]  efi/firmware/platform-x86: Add EFI embedded fw support
Date:   Tue, 10 Dec 2019 12:51:07 +0100
Message-Id: <20191210115117.303935-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: N3aFnNSYPpC2h3oQ9fY4YA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi All,

Here is v10 of my patch-set to add support for EFI embedded fw to the
kernel. This version has been rebased on top 5.5-rc1 to fix 2 conflicts
with the first 2 (efi) patches in the series. There are no changes
versus v9 other then the rebase.

Below is the cover-letter of v9:

The main new feature in this version is the addition of some selftests for
the new firmware_request_platform api (patch 5 and 6, both new). My plan
was to send the patches adding the selftests out as a follow up series.

But during unrelated testing of my personal tree I found a small but nasty
bug in the "efi: Add embedded peripheral firmware support" patch, the minor
refactoring done in v8 exposed a bug which causes a hard crash on boot for
devices which have a DMI match in the touchscreen_dmi_table but do not use
EFI-embedded fw, this is fixed in this new version.

Assuming the 2 new patches adding the selftests are ok, I believe that
this series is ready for merging now.  I believe it would be best to merge
patches 1-8 through Greg's driver-core tree where firmware-loader changes g=
o.
The non firmware patches already have Acked-by-s from the maintainers of
the EFI/input trees.

Patches 9-10 touch a quirks file under drivers/platform/x86 which sees
multipe updates each cycle. So my proposal is that once 1-8 has landed
Greg creates an immutable branch with those changes and then
Andy and/or Darren can merge in that branch and then apply 9 and 10.

Regards,

Hans


Changes in v10:
- Rebase on top of 5.5-rc1

Changes in v9:
- Add 2 new patches adding selftests
- At least touchscreen_dmi.c uses the same dmi_table for its own private
  data and the fw_desc structs, putting the fw_desc struct first in the
  data driver_data points to so that the dmi_table can be shared with
  efi_check_for_embedded_firmwares(). But not all entries there have
  embedded-fw so in some cases the fw_desc is empty (zero-ed out).
  This can lead to a possible crash because fw_desc->length now is
  less then 8, so if the segment size is close enough to a multiple of the
  page_size, then the memcmp to check the prefix my segfault. Crashing the
  machine. v9 checks for and skips these empty fw_desc entries avoiding thi=
s.
- Add static inline wrapper for firmware_request_platform() to firmware.h,
  for when CONFIG_FW_LOADER is not set

Changes in v8:
- Add pr_warn if there are mode then EFI_DEBUGFS_MAX_BLOBS boot service seg=
ments
- Document how the EFI debugfs boot_service_code? files can be used to chec=
k for
  embedded firmware
- Properly deal with the case of an EFI segment being smaller then the fw w=
e
  are looking for
- Log a warning when efi_get_embedded_fw get called while we did not (yet)
  check for embedded firmwares
- Only build fallback_platform.c if CONFIG_EFI_EMBEDDED_FIRMWARE is defined=
,
  otherwise make firmware_fallback_platform() a static inline stub

Changes in v7:
- Split drivers/firmware/efi and drivers/base/firmware_loader changes into
  2 patches
- Use new, standalone, lib/crypto/sha256.c code
- Address kdoc comments from Randy Dunlap
- Add new FW_OPT_FALLBACK_PLATFORM flag and firmware_request_platform()
  _request_firmware() wrapper, as requested by Luis R. Rodriguez
- Stop using "efi-embedded-firmware" device-property, now that drivers need=
 to
  use the new firmware_request_platform() to enable fallback to a device fw
  copy embedded in the platform's main firmware, we no longer need a proper=
ty
  on the device to trigger this behavior
- Use security_kernel_load_data instead of calling
  security_kernel_read_file with a NULL file pointer argument
- Move the docs to Documentation/driver-api/firmware/fallback-mechanisms.rs=
t
- Document the new firmware_request_platform() function in
  Documentation/driver-api/firmware/request_firmware.rst
- Add 2 new patches for the silead and chipone-icn8505 touchscreen drivers
  to use the new firmware_request_platform() method
- Rebased on top of 5.4-rc1

Changes in v6:
-Rework code to remove casts from if (prefix =3D=3D mem) comparison
-Use SHA256 hashes instead of crc32 sums
-Add new READING_FIRMWARE_EFI_EMBEDDED read_file_id and use it
-Call security_kernel_read_file(NULL, READING_FIRMWARE_EFI_EMBEDDED)
 to check if this is allowed before looking at EFI embedded fw
-Document why we are not using the PI Firmware Volume protocol

Changes in v5:
-Rename the EFI_BOOT_SERVICES flag to EFI_PRESERVE_BS_REGIONS

Changes in v4:
-Drop note in docs about EFI_FIRMWARE_VOLUME_PROTOCOL, it is not part of
 UEFI proper, so the EFI maintainers don't want us referring people to it
-Use new EFI_BOOT_SERVICES flag
-Put the new fw_get_efi_embedded_fw() function in its own fallback_efi.c
 file which only gets built when EFI_EMBEDDED_FIRMWARE is selected
-Define an empty stub for fw_get_efi_embedded_fw() in fallback.h hwen
 EFI_EMBEDDED_FIRMWARE is not selected, to avoid the need for #ifdefs
 in firmware_loader/main.c
-Properly call security_kernel_post_read_file() on the firmware returned
 by efi_get_embedded_fw() to make sure that we are allowed to use it

Changes in v2:
-Rebased on driver-core/driver-core-next
-Add documentation describing the EFI embedded firmware mechanism to:
 Documentation/driver-api/firmware/request_firmware.rst
-Add a new EFI_EMBEDDED_FIRMWARE Kconfig bool and only build the embedded
 fw support if this is set. This is an invisible option which should be
 selected by drivers which need this
-Remove the efi_embedded_fw_desc and dmi_system_id-s for known devices
 from the efi-embedded-fw code, instead drivers using this are expected to
 export a dmi_system_id array, with each entries' driver_data pointing to a
 efi_embedded_fw_desc struct and register this with the efi-embedded-fw cod=
e
-Use kmemdup to make a copy instead of efi_mem_reserve()-ing the firmware,
 this avoids us messing with the EFI memmap and avoids the need to make
 changes to efi_mem_desc_lookup()
-Make the firmware-loader code only fallback to efi_get_embedded_fw() if th=
e
 passed in device has the "efi-embedded-firmware" device-property bool set
-Skip usermodehelper fallback when "efi-embedded-firmware" device-property
 is set


