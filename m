Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3359FE165
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2019 16:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbfKOPfn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Nov 2019 10:35:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59539 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727561AbfKOPfn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Nov 2019 10:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573832141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xqcdBBD6i/yTJlbJJBJWml3mpntL2Br9E0z7m9Zrr7Y=;
        b=El5rwegE/PQNyJEL3cblkZZebmu/tsX1pGCCZM0gqHiFZ0MGXM+Byxezq8HlxccKDVHHgc
        nltv958SW88XcDvIRdykPTtTSpPz8wZbbjjb9MXnGKkKtinnb0jZqUo7fHnG6c+pcoz0FX
        M8oHsufALzqs5flX8MZuF5l7mKuQ4LE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-JumWuZpGNrS_4N71YYFAcw-1; Fri, 15 Nov 2019 10:35:37 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 461C3DB6F;
        Fri, 15 Nov 2019 15:35:35 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-154.ams2.redhat.com [10.36.116.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A9426106C;
        Fri, 15 Nov 2019 15:35:31 +0000 (UTC)
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
Subject: [PATCH v8 0/8] efi/firmware/platform-x86: Add EFI embedded fw support
Date:   Fri, 15 Nov 2019 16:35:21 +0100
Message-Id: <20191115153529.215244-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: JumWuZpGNrS_4N71YYFAcw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Here is v8 of my patch-set to add support for EFI embedded fw to the kernel=
.
This new version should address the few small remarks Luis had for v7,
see below for the full changelog.

I believe that this patch-set is ready for merging now. I believe it
would be best to merge patches 1-6 through Greg's driver-core tree
where firmware-loader changes go. Dmitry already gave his Acked-by
for doing this with patches 5 and 6.

Ard, you already gave your Acked-by for the changes in patches 1-2
to indicate you are ok with the changes in general, are you also ok
with merging these changes through Greg's driver-core tree?

Patches 7-8 touch a quirks file under drivers/platform/x86 which sees
multipe updates each cycle. So my proposal is that once 1-6 has landed
Greg creates an immutable branch with those changes and then
Andy and/or Darren can merge in that branch and then apply 7 and 8.

Regards,

Hans


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

