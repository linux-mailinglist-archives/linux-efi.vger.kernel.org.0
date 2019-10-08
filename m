Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95AD0D0093
	for <lists+linux-efi@lfdr.de>; Tue,  8 Oct 2019 20:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfJHSPm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 8 Oct 2019 14:15:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60458 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbfJHSPm (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 8 Oct 2019 14:15:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0AAA110CC1E9;
        Tue,  8 Oct 2019 18:15:39 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-109.rdu2.redhat.com [10.10.120.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15059100194E;
        Tue,  8 Oct 2019 18:15:28 +0000 (UTC)
Subject: Re: [PATCH v2] efi/efi_test: lock down /dev/efi_test and require
 CAP_SYS_ADMIN
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Ivan Hu <ivan.hu@canonical.com>, linux-efi@vger.kernel.org,
        Laura Abbott <labbott@redhat.com>,
        Josh Boyer <jwboyer@redhat.com>,
        Peter Jones <pjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        Micah Morton <mortonm@chromium.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        James Morris <jmorris@namei.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Garrett <matthewgarrett@google.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <20191008105510.6975-1-javierm@redhat.com>
From:   Laszlo Ersek <lersek@redhat.com>
Message-ID: <affd623b-2e9f-cb10-f9e8-c14b8c5f186c@redhat.com>
Date:   Tue, 8 Oct 2019 20:15:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191008105510.6975-1-javierm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Tue, 08 Oct 2019 18:15:41 +0000 (UTC)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/08/19 12:55, Javier Martinez Canillas wrote:
> The driver exposes EFI runtime services to user-space through an IOCTL
> interface, calling the EFI services function pointers directly without
> using the efivar API.
> 
> Disallow access to the /dev/efi_test character device when the kernel is
> locked down to prevent arbitrary user-space to call EFI runtime services.
> 
> Also require CAP_SYS_ADMIN to open the chardev to prevent unprivileged
> users to call the EFI runtime services, instead of just relying on the
> chardev file mode bits for this.
> 
> The main user of this driver is the fwts [0] tool that already checks if
> the effective user ID is 0 and fails otherwise. So this change shouldn't
> cause any regression to this tool.
> 
> [0]: https://wiki.ubuntu.com/FirmwareTestSuite/Reference/uefivarinfo
> 
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Laszlo Ersek <lersek@redhat.com>
> 
> ---
> 
> Changes in v2:
> - Also disable /dev/efi_test access when the kernel is locked down as
>   suggested by Matthew Garrett.

Right; if you remember the pre-patch discussion off-list, we kind of
expected that lockdown might affect this. :)

... And, I can see Matt's comment now, at
<https://bugzilla.redhat.com/show_bug.cgi?id=1759325#c1>. Thanks for that!

While this change decreases the usability of the module, I fully agree
it is justified for production use. While it's more convenient for me to
keep SB enabled in the test VM(s) in general, and just run the test
whenever I need it, security trumps convenience. I can disable SB when
necessary, or even dedicate separate VMs (with SB generally disabled) to
this kind of testing.

> - Add Acked-by tag from Laszlo Ersek.

My ACK stands -- I don't know enough to validate the
security_locked_down() call and its friends, but I'm OK with the intent.

Thanks all!
Laszlo

> 
>  drivers/firmware/efi/test/efi_test.c | 8 ++++++++
>  include/linux/security.h             | 1 +
>  security/lockdown/lockdown.c         | 1 +
>  3 files changed, 10 insertions(+)
> 
> diff --git a/drivers/firmware/efi/test/efi_test.c b/drivers/firmware/efi/test/efi_test.c
> index 877745c3aaf..7baf48c01e7 100644
> --- a/drivers/firmware/efi/test/efi_test.c
> +++ b/drivers/firmware/efi/test/efi_test.c
> @@ -14,6 +14,7 @@
>  #include <linux/init.h>
>  #include <linux/proc_fs.h>
>  #include <linux/efi.h>
> +#include <linux/security.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
>  
> @@ -717,6 +718,13 @@ static long efi_test_ioctl(struct file *file, unsigned int cmd,
>  
>  static int efi_test_open(struct inode *inode, struct file *file)
>  {
> +	int ret = security_locked_down(LOCKDOWN_EFI_TEST);
> +
> +	if (ret)
> +		return ret;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EACCES;
>  	/*
>  	 * nothing special to do here
>  	 * We do accept multiple open files at the same time as we
> diff --git a/include/linux/security.h b/include/linux/security.h
> index a8d59d612d2..9df7547afc0 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -105,6 +105,7 @@ enum lockdown_reason {
>  	LOCKDOWN_NONE,
>  	LOCKDOWN_MODULE_SIGNATURE,
>  	LOCKDOWN_DEV_MEM,
> +	LOCKDOWN_EFI_TEST,
>  	LOCKDOWN_KEXEC,
>  	LOCKDOWN_HIBERNATION,
>  	LOCKDOWN_PCI_ACCESS,
> diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
> index 8a10b43daf7..40b790536de 100644
> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -20,6 +20,7 @@ static const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>  	[LOCKDOWN_NONE] = "none",
>  	[LOCKDOWN_MODULE_SIGNATURE] = "unsigned module loading",
>  	[LOCKDOWN_DEV_MEM] = "/dev/mem,kmem,port",
> +	[LOCKDOWN_EFI_TEST] = "/dev/efi_test access",
>  	[LOCKDOWN_KEXEC] = "kexec of unsigned images",
>  	[LOCKDOWN_HIBERNATION] = "hibernation",
>  	[LOCKDOWN_PCI_ACCESS] = "direct PCI access",
> 

