Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09F9C1025D9
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2019 15:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725280AbfKSOD5 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Nov 2019 09:03:57 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36230 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727626AbfKSOD4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Nov 2019 09:03:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574172234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gtnF2I4P9OtqsTzvchU/T19l1l/5zs1rbv+02nY6Y74=;
        b=FArqO+7WOqWl9ymRLDXpou8PldVsP5goDCNxBZChTRGHH9UtDTcvSWeJB01UwuPB7OKCJb
        U60UlIzd9DWnaEJ+xqghxQSpmJiHeAoE2EbCCecytTa9QmUaWPluIEpsjgGkJDeQudMTqx
        p9NrxulOs/gDZgBQdpXCaHeo6taOfwE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-kofVFh89M6mFYQA_YmCTuQ-1; Tue, 19 Nov 2019 09:03:53 -0500
Received: by mail-wr1-f69.google.com with SMTP id e10so18201753wrt.16
        for <linux-efi@vger.kernel.org>; Tue, 19 Nov 2019 06:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1efGFCoQ04/i9yYZO1URcgU4/AsozMwISUCZiEggQ+o=;
        b=cx4kybgYFvFI2R39MrmswslIR8c7l8RONyb4liJl+BjM21l04xKIgv2M9I+Qb7sdO1
         bAymjTNCnm4uqTMSRj9XyrzUQKpIAQrlpHTFdmCEW26X8js43MFj6kEJ2dlAKT+RAUBj
         orq2Tbpq67MQUKsU95YOtdqfaZek3Uz+cbh4OyZUp4MOViWt0avnPbHY1AgUCVkVe0I/
         JO+2HlVsSxAKuhdcVlO2J9O7pwIy8xr6TDzx0GllzpM35+xTKwyOliYlmHUoBNarL4y3
         cxdM61ZGxyciBN8x0n6E1sW6Aax4motE5UlvK01JBc6jtSbrymRCM+wXjQKpmyBQ64Bu
         1B9g==
X-Gm-Message-State: APjAAAWEZ29v4/XP7qjWCN04CV2vn+YQtzMg5eBOOpauuKzpGqnRi+8g
        FLPg6XVo+UBFPMcHie4gX/iukLRkaMeKujfXpoZ64xjmssLsLggzsCLTeIeOw9iRDrCT4+g/sbW
        jbvuCAC4LS4MGud+Kd2Nt
X-Received: by 2002:a7b:c207:: with SMTP id x7mr5782674wmi.40.1574172231083;
        Tue, 19 Nov 2019 06:03:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqx549hyaH0Ymq7Ymdj21FpecojASQirdnlnm18+8KQa3+eAI4CrAAFy80xG5VFHlxmP+/dw4g==
X-Received: by 2002:a7b:c207:: with SMTP id x7mr5782601wmi.40.1574172230507;
        Tue, 19 Nov 2019 06:03:50 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id w132sm3501187wma.6.2019.11.19.06.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2019 06:03:49 -0800 (PST)
Subject: Re: [PATCH v8 4/8] firmware: Add new platform fallback mechanism and
 firmware_request_platform()
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20191115153529.215244-1-hdegoede@redhat.com>
 <20191115153529.215244-5-hdegoede@redhat.com>
 <20191118213542.GI11244@42.do-not-panic.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <c559a739-6be3-ae3e-e641-4ae82ffe71f6@redhat.com>
Date:   Tue, 19 Nov 2019 15:03:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191118213542.GI11244@42.do-not-panic.com>
Content-Language: en-US
X-MC-Unique: kofVFh89M6mFYQA_YmCTuQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 18-11-2019 22:35, Luis Chamberlain wrote:
> On Fri, Nov 15, 2019 at 04:35:25PM +0100, Hans de Goede wrote:
>> In some cases the platform's main firmware (e.g. the UEFI fw) may contai=
n
>> an embedded copy of device firmware which needs to be (re)loaded into th=
e
>> peripheral. Normally such firmware would be part of linux-firmware, but =
in
>> some cases this is not feasible, for 2 reasons:
>>
>> 1) The firmware is customized for a specific use-case of the chipset / u=
se
>> with a specific hardware model, so we cannot have a single firmware file
>> for the chipset. E.g. touchscreen controller firmwares are compiled
>> specifically for the hardware model they are used with, as they are
>> calibrated for a specific model digitizer.
>>
>> 2) Despite repeated attempts we have failed to get permission to
>> redistribute the firmware. This is especially a problem with customized
>> firmwares, these get created by the chip vendor for a specific ODM and t=
he
>> copyright may partially belong with the ODM, so the chip vendor cannot
>> give a blanket permission to distribute these.
>>
>> This commit adds a new platform fallback mechanism to the firmware loade=
r
>> which will try to lookup a device fw copy embedded in the platform's mai=
n
>> firmware if direct filesystem lookup fails.
>>
>> Drivers which need such embedded fw copies can enable this fallback
>> mechanism by using the new firmware_request_platform() function.
>>
>> Note that for now this is only supported on EFI platforms and even on
>> these platforms firmware_fallback_platform() only works if
>> CONFIG_EFI_EMBEDDED_FIRMWARE is enabled (this gets selected by drivers
>> which need this), in all other cases firmware_fallback_platform() simply
>> always returns -ENOENT.
>>
>> Reported-by: Dave Olsthoorn <dave@bewaar.me>
>> Suggested-by: Peter Jones <pjones@redhat.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>=20
> This looks good to me now thanks!
>=20
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
>=20
> Just one more thing: testing. Since this requires EFI memeory, I guess
> we can't mimic a fake firmware somehow to use to test the API on any x86
> system? If not we'd have no test coverage through the selftests for this
> new call at all, and so could not easily detect regressions. We could
> perhaps *fake* an entry if a DEBUG kconfig option is enabled, which
> would stuff the EFI fw entry *once*. What do you think?

We could give the found_fw_list list_head from drivers/firmware/efi/embedde=
d-firmware.c
a name which is better suited for exporting it and then actually export it.
That combined with moving the struct embedded_fw type declaration into
linux/efi_embedded_fw.h, with a note saying that it is private and should o=
nly
be used for the selftests.

Then a selftest can indeed simply add a fake fw entry to the list and then
excercise the API and check that it gets the contents of its own fake
entry back.

Hmm, I see that the tests under tools/testing/selftests/firmware
are doing everything through a special sysfs API, in case of testing
the userspace fallbacks this makes sense, but in this case I
was thinking more along the lines of writing the test itself in a
module (or add it to the lib/test_firmware.c) module rather then doing
this complex dance.

I guess this test could just be another store method for a new sysfs
attribute, which does not interact with any of the state/config, like the
trigger_request test.

I can try to write a follow up series which does this this weekend.

Regards,

Hans



>=20
> Look at: lib/test_firmware.c and tools/testing/selftests/firmware/
>=20
>    Luis
>=20
>> ---
>> Changes in v8:
>> - Only build fallback_platform.c if CONFIG_EFI_EMBEDDED_FIRMWARE is defi=
ned,
>>    otherwise make firmware_fallback_platform() a static inline stub
>> - Add documentation to Documentation/driver-api/firmware/fallback-mechan=
isms.rst
>>    on how the boot_service_code? files exported by EFI debugfs can be us=
ed to
>>    check if there is an embedded firmware and to get the embedded firmwa=
re
>>    length and sha256sum
>>
>> Changes in v7:
>> - Split drivers/firmware/efi and drivers/base/firmware_loader changes in=
to
>>    2 patches
>> - Address kdoc comments from Randy Dunlap
>> - Add new FW_OPT_FALLBACK_PLATFORM flag and firmware_request_platform()
>>    _request_firmware() wrapper, as requested by Luis R. Rodriguez
>> - Stop using "efi-embedded-firmware" device-property, now that drivers n=
eed to
>>    use the new firmware_request_platform() to enable fallback to a devic=
e fw
>>    copy embedded in the platform's main firmware, we no longer need a pr=
operty
>>    on the device to trigger this behavior
>> - Use security_kernel_load_data instead of calling
>>    security_kernel_read_file with a NULL file pointer argument
>> - Move the docs to Documentation/driver-api/firmware/fallback-mechanisms=
.rst
>> - Document the new firmware_request_platform() function in
>>    Documentation/driver-api/firmware/request_firmware.rst
>>
>> Changes in v6:
>> - Rework code to remove casts from if (prefix =3D=3D mem) comparison
>> - Use SHA256 hashes instead of crc32 sums
>> - Add new READING_FIRMWARE_EFI_EMBEDDED read_file_id and use it
>> - Call security_kernel_read_file(NULL, READING_FIRMWARE_EFI_EMBEDDED)
>>    to check if this is allowed before looking at EFI embedded fw
>> - Document why we are not using the UEFI PI Firmware Volume protocol
>>
>> Changes in v5:
>> - Rename the EFI_BOOT_SERVICES flag to EFI_PRESERVE_BS_REGIONS
>>
>> Changes in v4:
>> - Drop note in docs about EFI_FIRMWARE_VOLUME_PROTOCOL, it is not part o=
f
>>    UEFI proper, so the EFI maintainers don't want us referring people to=
 it
>> - Use new EFI_BOOT_SERVICES flag
>> - Put the new fw_get_efi_embedded_fw() function in its own fallback_efi.=
c
>>    file which only gets built when EFI_EMBEDDED_FIRMWARE is selected
>> - Define an empty stub for fw_get_efi_embedded_fw() in fallback.h hwen
>>    EFI_EMBEDDED_FIRMWARE is not selected, to avoid the need for #ifdefs
>>    in firmware_loader/main.c
>> - Properly call security_kernel_post_read_file() on the firmware returne=
d
>>    by efi_get_embedded_fw() to make sure that we are allowed to use it
>>
>> Changes in v3:
>> - Fix the docs using "efi-embedded-fw" as property name instead of
>>    "efi-embedded-firmware"
>>
>> Changes in v2:
>> - Rebased on driver-core/driver-core-next
>> - Add documentation describing the EFI embedded firmware mechanism to:
>>    Documentation/driver-api/firmware/request_firmware.rst
>> - Add a new EFI_EMBEDDED_FIRMWARE Kconfig bool and only build the embedd=
ed
>>    fw support if this is set. This is an invisible option which should b=
e
>>    selected by drivers which need this
>> - Remove the efi_embedded_fw_desc and dmi_system_id-s for known devices
>>    from the efi-embedded-fw code, instead drivers using this are expecte=
d to
>>    export a dmi_system_id array, with each entries' driver_data pointing=
 to a
>>    efi_embedded_fw_desc struct and register this with the efi-embedded-f=
w code
>> - Use kmemdup to make a copy instead of efi_mem_reserve()-ing the firmwa=
re,
>>    this avoids us messing with the EFI memmap and avoids the need to mak=
e
>>    changes to efi_mem_desc_lookup()
>> - Make the firmware-loader code only fallback to efi_get_embedded_fw() i=
f the
>>    passed in device has the "efi-embedded-firmware" device-property bool=
 set
>> - Skip usermodehelper fallback when "efi-embedded-firmware" device-prope=
rty
>>    is set
>> ---
>>   .../firmware/fallback-mechanisms.rst          | 103 ++++++++++++++++++
>>   .../driver-api/firmware/lookup-order.rst      |   2 +
>>   .../driver-api/firmware/request_firmware.rst  |   5 +
>>   drivers/base/firmware_loader/Makefile         |   1 +
>>   drivers/base/firmware_loader/fallback.h       |  10 ++
>>   .../base/firmware_loader/fallback_platform.c  |  29 +++++
>>   drivers/base/firmware_loader/firmware.h       |   4 +
>>   drivers/base/firmware_loader/main.c           |  27 +++++
>>   include/linux/firmware.h                      |   2 +
>>   include/linux/fs.h                            |   1 +
>>   10 files changed, 184 insertions(+)
>>   create mode 100644 drivers/base/firmware_loader/fallback_platform.c
>>
>> diff --git a/Documentation/driver-api/firmware/fallback-mechanisms.rst b=
/Documentation/driver-api/firmware/fallback-mechanisms.rst
>> index 8b041d0ab426..036383dad6d6 100644
>> --- a/Documentation/driver-api/firmware/fallback-mechanisms.rst
>> +++ b/Documentation/driver-api/firmware/fallback-mechanisms.rst
>> @@ -202,3 +202,106 @@ the following file:
>>  =20
>>   If you echo 0 into it means MAX_JIFFY_OFFSET will be used. The data ty=
pe
>>   for the timeout is an int.
>> +
>> +EFI embedded firmware fallback mechanism
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +On some devices the system's EFI code / ROM may contain an embedded cop=
y
>> +of firmware for some of the system's integrated peripheral devices and
>> +the peripheral's Linux device-driver needs to access this firmware.
>> +
>> +Device drivers which need such firmware can use the
>> +firmware_request_platform() function for this, note that this is a
>> +separate fallback mechanism from the other fallback mechanisms and
>> +this does not use the sysfs interface.
>> +
>> +A device driver which needs this can describe the firmware it needs
>> +using an efi_embedded_fw_desc struct:
>> +
>> +.. kernel-doc:: include/linux/efi_embedded_fw.h
>> +   :functions: efi_embedded_fw_desc
>> +
>> +The EFI embedded-fw code works by scanning all EFI_BOOT_SERVICES_CODE m=
emory
>> +segments for an eight byte sequence matching prefix; if the prefix is f=
ound it
>> +then does a sha256 over length bytes and if that matches makes a copy o=
f length
>> +bytes and adds that to its list with found firmwares.
>> +
>> +To avoid doing this somewhat expensive scan on all systems, dmi matchin=
g is
>> +used. Drivers are expected to export a dmi_system_id array, with each e=
ntries'
>> +driver_data pointing to an efi_embedded_fw_desc.
>> +
>> +To register this array with the efi-embedded-fw code, a driver needs to=
:
>> +
>> +1. Always be builtin to the kernel or store the dmi_system_id array in =
a
>> +   separate object file which always gets builtin.
>> +
>> +2. Add an extern declaration for the dmi_system_id array to
>> +   include/linux/efi_embedded_fw.h.
>> +
>> +3. Add the dmi_system_id array to the embedded_fw_table in
>> +   drivers/firmware/efi/embedded-firmware.c wrapped in a #ifdef testing=
 that
>> +   the driver is being builtin.
>> +
>> +4. Add "select EFI_EMBEDDED_FIRMWARE if EFI_STUB" to its Kconfig entry.
>> +
>> +The firmware_request_platform() function will always first try to load =
firmware
>> +with the specified name directly from the disk, so the EFI embedded-fw =
can
>> +always be overridden by placing a file under /lib/firmware.
>> +
>> +Note that:
>> +
>> +1. The code scanning for EFI embedded-firmware runs near the end
>> +   of start_kernel(), just before calling rest_init(). For normal drive=
rs and
>> +   subsystems using subsys_initcall() to register themselves this does =
not
>> +   matter. This means that code running earlier cannot use EFI
>> +   embedded-firmware.
>> +
>> +2. At the moment the EFI embedded-fw code assumes that firmwares always=
 start at
>> +   an offset which is a multiple of 8 bytes, if this is not true for yo=
ur case
>> +   send in a patch to fix this.
>> +
>> +3. At the moment the EFI embedded-fw code only works on x86 because oth=
er archs
>> +   free EFI_BOOT_SERVICES_CODE before the EFI embedded-fw code gets a c=
hance to
>> +   scan it.
>> +
>> +4. The current brute-force scanning of EFI_BOOT_SERVICES_CODE is an ad-=
hoc
>> +   brute-force solution. There has been discussion to use the UEFI Plat=
form
>> +   Initialization (PI) spec's Firmware Volume protocol. This has been r=
ejected
>> +   because the FV Protocol relies on *internal* interfaces of the PI sp=
ec, and:
>> +   1. The PI spec does not define peripheral firmware at all
>> +   2. The internal interfaces of the PI spec do not guarantee any backw=
ard
>> +   compatibility. Any implementation details in FV may be subject to ch=
ange,
>> +   and may vary system to system. Supporting the FV Protocol would be
>> +   difficult as it is purposely ambiguous.
>> +
>> +Example how to check for and extract embedded firmware
>> +------------------------------------------------------
>> +
>> +To check for, for example Silead touchscreen controller embedded firmwa=
re,
>> +do the following:
>> +
>> +1. Boot the system with efi=3Ddebug on the kernel commandline
>> +
>> +2. cp /sys/kernel/debug/efi/boot_services_code? to your home dir
>> +
>> +3. Open the boot_services_code? files in a hex-editor, search for the
>> +   magic prefix for Silead firmware: F0 00 00 00 02 00 00 00, this give=
s you
>> +   the beginning address of the firmware inside the boot_services_code?=
 file.
>> +
>> +4. The firmware has a specific pattern, it starts with a 8 byte page-ad=
dress,
>> +   typically F0 00 00 00 02 00 00 00 for the first page followed by 32-=
bit
>> +   word-address + 32-bit value pairs. With the word-address incrementin=
g 4
>> +   bytes (1 word) for each pair until a page is complete. A complete pa=
ge is
>> +   followed by a new page-address, followed by more word + value pairs.=
 This
>> +   leads to a very distinct pattern. Scroll down until this pattern sto=
ps,
>> +   this gives you the end of the firmware inside the boot_services_code=
? file.
>> +
>> +5. "dd if=3Dboot_services_code? of=3Dfirmware bs=3D1 skip=3D<begin-addr=
> count=3D<len>"
>> +   will extract the firmware for you. Inspect the firmware file in a
>> +   hexeditor to make sure you got the dd parameters correct.
>> +
>> +6. Copy it to /lib/firmware under the expected name to test it.
>> +
>> +7. If the extracted firmware works, you can use the found info to fill =
an
>> +   efi_embedded_fw_desc struct to describe it, run "sha256sum firmware"
>> +   to get the sha256sum to put in the sha256 field.
>> diff --git a/Documentation/driver-api/firmware/lookup-order.rst b/Docume=
ntation/driver-api/firmware/lookup-order.rst
>> index 88c81739683c..6064672a782e 100644
>> --- a/Documentation/driver-api/firmware/lookup-order.rst
>> +++ b/Documentation/driver-api/firmware/lookup-order.rst
>> @@ -12,6 +12,8 @@ a driver issues a firmware API call.
>>     return it immediately
>>   * The ''Direct filesystem lookup'' is performed next, if found we
>>     return it immediately
>> +* The ''Platform firmware fallback'' is performed next, but only when
>> +  firmware_request_platform() is used, if found we return it immediatel=
y
>>   * If no firmware has been found and the fallback mechanism was enabled
>>     the sysfs interface is created. After this either a kobject uevent
>>     is issued or the custom firmware loading is relied upon for firmware
>> diff --git a/Documentation/driver-api/firmware/request_firmware.rst b/Do=
cumentation/driver-api/firmware/request_firmware.rst
>> index f62bdcbfed5b..cd076462d235 100644
>> --- a/Documentation/driver-api/firmware/request_firmware.rst
>> +++ b/Documentation/driver-api/firmware/request_firmware.rst
>> @@ -25,6 +25,11 @@ firmware_request_nowarn
>>   .. kernel-doc:: drivers/base/firmware_loader/main.c
>>      :functions: firmware_request_nowarn
>>  =20
>> +firmware_request_platform
>> +-------------------------
>> +.. kernel-doc:: drivers/base/firmware_loader/main.c
>> +   :functions: firmware_request_platform
>> +
>>   request_firmware_direct
>>   -----------------------
>>   .. kernel-doc:: drivers/base/firmware_loader/main.c
>> diff --git a/drivers/base/firmware_loader/Makefile b/drivers/base/firmwa=
re_loader/Makefile
>> index 0b2dfa6259c9..e87843408fe6 100644
>> --- a/drivers/base/firmware_loader/Makefile
>> +++ b/drivers/base/firmware_loader/Makefile
>> @@ -5,5 +5,6 @@ obj-$(CONFIG_FW_LOADER_USER_HELPER) +=3D fallback_table.=
o
>>   obj-$(CONFIG_FW_LOADER)=09+=3D firmware_class.o
>>   firmware_class-objs :=3D main.o
>>   firmware_class-$(CONFIG_FW_LOADER_USER_HELPER) +=3D fallback.o
>> +firmware_class-$(CONFIG_EFI_EMBEDDED_FIRMWARE) +=3D fallback_platform.o
>>  =20
>>   obj-y +=3D builtin/
>> diff --git a/drivers/base/firmware_loader/fallback.h b/drivers/base/firm=
ware_loader/fallback.h
>> index 21063503e4ea..06f4577733a8 100644
>> --- a/drivers/base/firmware_loader/fallback.h
>> +++ b/drivers/base/firmware_loader/fallback.h
>> @@ -66,4 +66,14 @@ static inline void unregister_sysfs_loader(void)
>>   }
>>   #endif /* CONFIG_FW_LOADER_USER_HELPER */
>>  =20
>> +#ifdef CONFIG_EFI_EMBEDDED_FIRMWARE
>> +int firmware_fallback_platform(struct fw_priv *fw_priv, enum fw_opt opt=
_flags);
>> +#else
>> +static inline int firmware_fallback_platform(struct fw_priv *fw_priv,
>> +=09=09=09=09=09     enum fw_opt opt_flags)
>> +{
>> +=09return -ENOENT;
>> +}
>> +#endif
>> +
>>   #endif /* __FIRMWARE_FALLBACK_H */
>> diff --git a/drivers/base/firmware_loader/fallback_platform.c b/drivers/=
base/firmware_loader/fallback_platform.c
>> new file mode 100644
>> index 000000000000..37746efaf8e3
>> --- /dev/null
>> +++ b/drivers/base/firmware_loader/fallback_platform.c
>> @@ -0,0 +1,29 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/efi_embedded_fw.h>
>> +#include <linux/property.h>
>> +#include <linux/security.h>
>> +#include <linux/vmalloc.h>
>> +
>> +#include "fallback.h"
>> +#include "firmware.h"
>> +
>> +int firmware_fallback_platform(struct fw_priv *fw_priv, enum fw_opt opt=
_flags)
>> +{
>> +=09int rc;
>> +
>> +=09if (!(opt_flags & FW_OPT_FALLBACK_PLATFORM))
>> +=09=09return -ENOENT;
>> +
>> +=09rc =3D security_kernel_load_data(LOADING_FIRMWARE_EFI_EMBEDDED);
>> +=09if (rc)
>> +=09=09return rc;
>> +
>> +=09rc =3D efi_get_embedded_fw(fw_priv->fw_name, &fw_priv->data,
>> +=09=09=09=09 &fw_priv->size);
>> +=09if (rc)
>> +=09=09return rc; /* rc =3D=3D -ENOENT when the fw was not found */
>> +
>> +=09fw_state_done(fw_priv);
>> +=09return 0;
>> +}
>> diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firm=
ware_loader/firmware.h
>> index 8656e5239a80..25836a6afc9f 100644
>> --- a/drivers/base/firmware_loader/firmware.h
>> +++ b/drivers/base/firmware_loader/firmware.h
>> @@ -29,6 +29,9 @@
>>    *=09firmware caching mechanism.
>>    * @FW_OPT_NOFALLBACK_SYSFS: Disable the sysfs fallback mechanism. Tak=
es
>>    *=09precedence over &FW_OPT_UEVENT and &FW_OPT_USERHELPER.
>> + * @FW_OPT_FALLBACK_PLATFORM: Enable fallback to device fw copy embedde=
d in
>> + *=09the platform's main firmware. If both this fallback and the sysfs
>> + *      fallback are enabled, then this fallback will be tried first.
>>    */
>>   enum fw_opt {
>>   =09FW_OPT_UEVENT=09=09=09=3D BIT(0),
>> @@ -37,6 +40,7 @@ enum fw_opt {
>>   =09FW_OPT_NO_WARN=09=09=09=3D BIT(3),
>>   =09FW_OPT_NOCACHE=09=09=09=3D BIT(4),
>>   =09FW_OPT_NOFALLBACK_SYSFS=09=09=3D BIT(5),
>> +=09FW_OPT_FALLBACK_PLATFORM=09=3D BIT(6),
>>   };
>>  =20
>>   enum fw_status {
>> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware=
_loader/main.c
>> index 08f8995a530a..006ff71458b1 100644
>> --- a/drivers/base/firmware_loader/main.c
>> +++ b/drivers/base/firmware_loader/main.c
>> @@ -775,6 +775,9 @@ _request_firmware(const struct firmware **firmware_p=
, const char *name,
>>   =09=09=09=09=09=09 fw_decompress_xz);
>>   #endif
>>  =20
>> +=09if (ret =3D=3D -ENOENT)
>> +=09=09ret =3D firmware_fallback_platform(fw->priv, opt_flags);
>> +
>>   =09if (ret) {
>>   =09=09if (!(opt_flags & FW_OPT_NO_WARN))
>>   =09=09=09dev_warn(device,
>> @@ -882,6 +885,30 @@ int request_firmware_direct(const struct firmware *=
*firmware_p,
>>   }
>>   EXPORT_SYMBOL_GPL(request_firmware_direct);
>>  =20
>> +/**
>> + * firmware_request_platform() - request firmware with platform-fw fall=
back
>> + * @firmware: pointer to firmware image
>> + * @name: name of firmware file
>> + * @device: device for which firmware is being loaded
>> + *
>> + * This function is similar in behaviour to request_firmware, except th=
at if
>> + * direct filesystem lookup fails, it will fallback to looking for a co=
py of the
>> + * requested firmware embedded in the platform's main (e.g. UEFI) firmw=
are.
>> + **/
>> +int firmware_request_platform(const struct firmware **firmware,
>> +=09=09=09      const char *name, struct device *device)
>> +{
>> +=09int ret;
>> +
>> +=09/* Need to pin this module until return */
>> +=09__module_get(THIS_MODULE);
>> +=09ret =3D _request_firmware(firmware, name, device, NULL, 0,
>> +=09=09=09=09FW_OPT_UEVENT | FW_OPT_FALLBACK_PLATFORM);
>> +=09module_put(THIS_MODULE);
>> +=09return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(firmware_request_platform);
>> +
>>   /**
>>    * firmware_request_cache() - cache firmware for suspend so resume can=
 use it
>>    * @name: name of firmware file
>> diff --git a/include/linux/firmware.h b/include/linux/firmware.h
>> index 2dd566c91d44..75dbec0bcc06 100644
>> --- a/include/linux/firmware.h
>> +++ b/include/linux/firmware.h
>> @@ -44,6 +44,8 @@ int request_firmware(const struct firmware **fw, const=
 char *name,
>>   =09=09     struct device *device);
>>   int firmware_request_nowarn(const struct firmware **fw, const char *na=
me,
>>   =09=09=09    struct device *device);
>> +int firmware_request_platform(const struct firmware **fw, const char *n=
ame,
>> +=09=09=09      struct device *device);
>>   int request_firmware_nowait(
>>   =09struct module *module, bool uevent,
>>   =09const char *name, struct device *device, gfp_t gfp, void *context,
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index e0d909d35763..3cbc955f6a1a 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -2961,6 +2961,7 @@ extern int do_pipe_flags(int *, int);
>>   =09id(UNKNOWN, unknown)=09=09\
>>   =09id(FIRMWARE, firmware)=09=09\
>>   =09id(FIRMWARE_PREALLOC_BUFFER, firmware)=09\
>> +=09id(FIRMWARE_EFI_EMBEDDED, firmware)=09\
>>   =09id(MODULE, kernel-module)=09=09\
>>   =09id(KEXEC_IMAGE, kexec-image)=09=09\
>>   =09id(KEXEC_INITRAMFS, kexec-initramfs)=09\
>> --=20
>> 2.23.0
>>
>=20

