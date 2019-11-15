Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09CB8FDD12
	for <lists+linux-efi@lfdr.de>; Fri, 15 Nov 2019 13:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfKOMKH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Nov 2019 07:10:07 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46612 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727380AbfKOMKG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Nov 2019 07:10:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573819805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4SLCfbXrVulZogYj/s2/SbxodvpIYXr2n3EpWJPZhgM=;
        b=KAwfXoDUMt79oH2UJ1qxtcISdk/vCJ2vI8C5Yjb5NA87QdSTj905CWNdoMHjbkh5iXKvLt
        4yUQ/7ikbMi7JNr+EDE6DB9Io7PYq+mtSOASndIUoQ3cfRHn6O/8MPGLvHAyFzyHbRqGdV
        VJ34aPdY8rgiuWpV9Z8MTSX0opRpeBI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-EZXjwozCNkWwMhdI3AjCMA-1; Fri, 15 Nov 2019 07:10:02 -0500
Received: by mail-wr1-f72.google.com with SMTP id w4so7542939wro.10
        for <linux-efi@vger.kernel.org>; Fri, 15 Nov 2019 04:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s4+dQMXVTzdXBza6cpCVy4c3dq1dN1YlKsihA8W4Y8Y=;
        b=gKluXB/RDbWnBG2HtBx7AulWiEi2F3207hVsUUqIO6i6usYMcwpVmjQc6gLpZ/H92/
         s//NBU5bJX4/QkJs9VvN1G3TmilkmUg4x6OzuNY+sG4olrMiZCBxi03OmDFcGX3Z4tmq
         8CQ84DS6I/I8yxiS8f4cD5DmLi6LfDvNO8a5g6aBjsM1IL05NlQL6rOmZpgtssyHafKC
         V5fwwYVpiTdvBjml61F80XlKqhtYE/jSmOYv3lju3n6Qm+Lx7LctHoYq/HTV0JuX71Iy
         WgsoakPqwZEtmv3t6nmEZqzg0cVDa3fHPCNNE2Z258DAP/7sSeN+Bz2PaX6mMZ7nfBkU
         +TIw==
X-Gm-Message-State: APjAAAUF7DYBzMGpUCupuWY2w73WiZYq0lNL5Y7CL0uTdUC5SjCC6Wm2
        rqTVogTv798a1DlRrOtXKo9BSI9kTpWtxA9FsU4L9xWSA1++7EX4IlCCPc9lM5X+NoAl/eXzPF3
        ttNZZYzKiKzF45AfIY4vb
X-Received: by 2002:a1c:30b:: with SMTP id 11mr13131546wmd.171.1573819801058;
        Fri, 15 Nov 2019 04:10:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxVn+PxOzHLWEYlmy0V5fELKmqUNxPX2dvbZL7DihUzDLfdB4tPBTsaLy1Ld99Eg+Qze1qseg==
X-Received: by 2002:a1c:30b:: with SMTP id 11mr13131526wmd.171.1573819800855;
        Fri, 15 Nov 2019 04:10:00 -0800 (PST)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id y8sm9103529wmi.9.2019.11.15.04.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 04:10:00 -0800 (PST)
Subject: Re: [PATCH v7 2/8] efi: Add embedded peripheral firmware support
To:     Luis Chamberlain <mcgrof@kernel.org>
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
References: <20191004145056.43267-1-hdegoede@redhat.com>
 <20191004145056.43267-3-hdegoede@redhat.com>
 <20191011144834.GL16384@42.do-not-panic.com>
 <e7bd40ff-20d1-3aed-8516-9fffd4c3a207@redhat.com>
 <20191114194233.GE11244@42.do-not-panic.com>
 <f00804ae-e556-35e4-d0a3-cd9201fdd2d0@redhat.com>
 <9b0a0121-3e63-0602-6c0d-00547e389f76@redhat.com>
 <20191114215009.GF11244@42.do-not-panic.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <d7546f63-5472-b867-4e79-912edf9cfa6c@redhat.com>
Date:   Fri, 15 Nov 2019 13:09:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191114215009.GF11244@42.do-not-panic.com>
Content-Language: en-US
X-MC-Unique: EZXjwozCNkWwMhdI3AjCMA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 14-11-2019 22:50, Luis Chamberlain wrote:
> On Thu, Nov 14, 2019 at 09:48:38PM +0100, Hans de Goede wrote:

<snip>

>> But I guess what you really want is some error to be thrown if someone
>> calls firmware_request_platform() before we are ready.
>=20
> Yes.
>=20
>> I guess I could make efi_check_for_embedded_firmwares() which scans
>> for known firmwares and saved a copy set a flag that it has run.
>>
>> And then combine that with making efi_get_embedded_fw() (which underpins
>> firmware_request_platform()) print a warning when called if that flag
>> is not set yet.

<snip>

> That'd be great.

So I've been working on this, my first though was to use WARN_ON as
calling this too early would be a bug, but there is a bunch of
normal circumstances where efi_check_for_embedded_firmwares() never
runs. One of the being classic BIOS boot, but e.g. also when running
paravirtualized in a paravirt env. using UEFI.

Normally we should not end up calling efi_get_embedded_fw() in those
cases, for one it is unlikely for any drivers using firmware_request_platfo=
rm()
to be used in such an environment, and if we somehow do end up with
a case where firmware_request_platform() is called, since the EFI
emebedded fw fallback then will not work I would expect a copy of
the necessary fw to be under /lib/firmware so we never hit the fallback.

This all makes efi_get_embedded_fw() getting called in cases where
efi_check_for_embedded_firmwares() will never run unlikely, but not
impossible. Making a WARN_ON the wrong thing to do so for v8 of this
patch-set I will add a pr_warn for this.

Note I've looked into detecting all the circumstances where it is normal
for efi_check_for_embedded_firmwares() to never run, but after tracing
the call path leading up to it getting called I've found that a check
for that is complicated and more importantly error-prone and likely
to get out of sync with reality if any of the functions higher up
the call path ever change the conditions.

So a pr_warn it is, and since as explained one would normally not
expect to ever hit the fallback on systems where
efi_check_for_embedded_firmwares() does not get called, I see no
harm in simply always printing the warning if
efi_check_for_embedded_firmwares() was not called.

Regards,

Hans

