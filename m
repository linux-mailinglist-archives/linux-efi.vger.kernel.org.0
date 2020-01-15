Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1996B13C981
	for <lists+linux-efi@lfdr.de>; Wed, 15 Jan 2020 17:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgAOQgK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Jan 2020 11:36:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51608 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728963AbgAOQgH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Jan 2020 11:36:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579106165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CknHfYKWUNK5GcbKJdElULBCITv+VJprQup5+AelWm0=;
        b=cWgOSkIupKihGCdNXnI0gI28Xar7vTChVVVlzHl6xbWhfvEQZxZXE4cQ506z+ogaxzNXSb
        3LHq1u8puPGvFO6ASMICKDfbRaEBCNkB7NRVZuL2yB4qxvwWrIQ7C0qP8OrnKDPvlcS4Yk
        eB7jIEUDGCLfMZaY3DJ8HtIm3FOKoMs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-FsobDYmfMzmQT8wayFPFtw-1; Wed, 15 Jan 2020 11:36:04 -0500
X-MC-Unique: FsobDYmfMzmQT8wayFPFtw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64120800D50;
        Wed, 15 Jan 2020 16:36:00 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-188.ams2.redhat.com [10.36.116.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0180D5DA76;
        Wed, 15 Jan 2020 16:35:55 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Ard Biesheuvel <ardb@kernel.org>,
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
Subject: [PATCH v12 00/10] efi/firmware/platform-x86: Add EFI embedded fw support
Date:   Wed, 15 Jan 2020 17:35:44 +0100
Message-Id: <20200115163554.101315-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi All,

Here is v12 of my patch-set to add support for EFI embedded fw to the
kernel.

This version addresses Luis' review remarks for the test_firmware stuff
and addresses some of Andy Lutomirski's remarks (while for some others
I've explained why I've done things a certain way).

It would be nice if we could at least get patches 1 and 2 merged for
5.6 (assuming Andy is ok with them now), then we can get the rest merged
once 5.6-rc1 is out.

As mentioned in the v11 cover letter, I've based this version on Ard's
efi/next branch to avoid conflict with some changes already there.

Regards,

Hans

---
Changes in v12:
- Use memcmp to check the prefix in efi_check_for_embedded_firmwares()
- Move the vmalloc (vmemdup) for the firmware copy owned by the firmare
  subsys from efi_get_embedded_fw() to firmware_fallback_platform(), so
  that it is is in the same subsys as the vfree which eventually frees it=
.
- Use local / private firmware variable for the test instead of the
  global test_firmware variable and drop the mutex lock + unlock needed
  for accessing the global test_firmware variable

Changes in v11:
- Rebase on top of Ardb's efi/next
- Drop a couple of empty lines which snuck into:
  "test_firmware: add support for firmware_request_platform"

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
  less then 8, so if the segment size is close enough to a multiple of th=
e
  page_size, then the memcmp to check the prefix my segfault. Crashing th=
e
  machine. v9 checks for and skips these empty fw_desc entries avoiding t=
his.
- Add static inline wrapper for firmware_request_platform() to firmware.h=
,
  for when CONFIG_FW_LOADER is not set

Changes in v8:
- Add pr_warn if there are mode then EFI_DEBUGFS_MAX_BLOBS boot service s=
egments
- Document how the EFI debugfs boot_service_code? files can be used to ch=
eck for
  embedded firmware
- Properly deal with the case of an EFI segment being smaller then the fw=
 we
  are looking for
- Log a warning when efi_get_embedded_fw get called while we did not (yet=
)
  check for embedded firmwares
- Only build fallback_platform.c if CONFIG_EFI_EMBEDDED_FIRMWARE is defin=
ed,
  otherwise make firmware_fallback_platform() a static inline stub

Changes in v7:
- Split drivers/firmware/efi and drivers/base/firmware_loader changes int=
o
  2 patches
- Use new, standalone, lib/crypto/sha256.c code
- Address kdoc comments from Randy Dunlap
- Add new FW_OPT_FALLBACK_PLATFORM flag and firmware_request_platform()
  _request_firmware() wrapper, as requested by Luis R. Rodriguez
- Stop using "efi-embedded-firmware" device-property, now that drivers ne=
ed to
  use the new firmware_request_platform() to enable fallback to a device =
fw
  copy embedded in the platform's main firmware, we no longer need a prop=
erty
  on the device to trigger this behavior
- Use security_kernel_load_data instead of calling
  security_kernel_read_file with a NULL file pointer argument
- Move the docs to Documentation/driver-api/firmware/fallback-mechanisms.=
rst
- Document the new firmware_request_platform() function in
  Documentation/driver-api/firmware/request_firmware.rst
- Add 2 new patches for the silead and chipone-icn8505 touchscreen driver=
s
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
 from the efi-embedded-fw code, instead drivers using this are expected t=
o
 export a dmi_system_id array, with each entries' driver_data pointing to=
 a
 efi_embedded_fw_desc struct and register this with the efi-embedded-fw c=
ode
-Use kmemdup to make a copy instead of efi_mem_reserve()-ing the firmware=
,
 this avoids us messing with the EFI memmap and avoids the need to make
 changes to efi_mem_desc_lookup()
-Make the firmware-loader code only fallback to efi_get_embedded_fw() if =
the
 passed in device has the "efi-embedded-firmware" device-property bool se=
t
-Skip usermodehelper fallback when "efi-embedded-firmware" device-propert=
y
 is set

