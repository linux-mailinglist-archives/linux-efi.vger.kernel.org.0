Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 129F91381B2
	for <lists+linux-efi@lfdr.de>; Sat, 11 Jan 2020 15:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgAKO5N (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 11 Jan 2020 09:57:13 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31329 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729863AbgAKO5N (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 11 Jan 2020 09:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578754632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UgncGrnFowE8u+k/ldVYrFztdx0N+oG8D5u3IVPS3SY=;
        b=b0+Y7Xwh7PSUJVTQhaQ4JYAqCAZL2Hk+fc+GRgoUmaLHS0ssyq5oE7UNTNoTM04BCGjwPe
        eeSl6jZj6blFsv+aLteZKuHSdFIVF3b1AYy5dZDjCIQ50pheZVDe4cFNKfwqzs03QblLwK
        34WStBMzx7/fOoJrLKx3nyBSIBbdXIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-yMz7JXy5MH-3a3wiq0773w-1; Sat, 11 Jan 2020 09:57:11 -0500
X-MC-Unique: yMz7JXy5MH-3a3wiq0773w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7736801E70;
        Sat, 11 Jan 2020 14:57:08 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-84.ams2.redhat.com [10.36.116.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB3A587EC6;
        Sat, 11 Jan 2020 14:57:04 +0000 (UTC)
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
Subject: [PATCH v11 00/10] efi/firmware/platform-x86: Add EFI embedded fw support
Date:   Sat, 11 Jan 2020 15:56:53 +0100
Message-Id: <20200111145703.533809-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi All,

Here is v11 of my patch-set to add support for EFI embedded fw to the
kernel. This version has been rebased on Ardb's latest efi/next branch to
fix a (trivial) conflict caused by the
"efi/libstub: Remove 'sys_table_arg' from all function prototypes" commit=
 in
efi/next. The only other change in v11 is dropping a few empty lines whic=
h
snuck into the "test_firmware: add support for firmware_request_platform"
patch.

I believe that this series is ready for merging now, patches 3-8
and patches 9-10 depend on the first 2 patches, so we need to get those
merged first.

Ingo, can you create an immutable branch targetting 5.6 for Greg /
the driver-platform-x86 maintainers with these 2 patches in it ?

Note as mentioned I've based this version on Ard's efi/next branch so
if you decide to do the immutable-branch directly on yop of 5.5-rc1 you n=
eed
to manually fixup a conflict (or I can send you a version based on 5.5-rc=
1).

Once the immutable-branch is in place then Greg can merge 3-8 through his
driver core tree and 9 and 10 can be merged through the drivers-platform-=
x86
tree (there are no compile time dependencies between these 2 sets).

Regards,

Hans

---

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


