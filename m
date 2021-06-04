Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7D539B623
	for <lists+linux-efi@lfdr.de>; Fri,  4 Jun 2021 11:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhFDJnY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Jun 2021 05:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50259 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229962AbhFDJnX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 4 Jun 2021 05:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622799697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vInzNIEC7qJ5S09yd5rz53tVm0jzaytwZERB+pVm5Bo=;
        b=htpY4lpQguWBi3+PVNP6ZC6SycmRan5tqAwMpG7howyo7zqonwu8w7+zELF4U59lYYcK5/
        A927JroqudO7quVMDwkaVJuU/kmYpsYZaBXjBsUHta6pv8mZw4XC9swQkXMMdLS/dKyA+0
        K9p4hBtXYJKF1fMz/8cuxQjIAVG7stI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-7qF12OcONwijr_ZfU1PfIA-1; Fri, 04 Jun 2021 05:41:33 -0400
X-MC-Unique: 7qF12OcONwijr_ZfU1PfIA-1
Received: by mail-wr1-f72.google.com with SMTP id x9-20020a5d49090000b0290118d8746e06so3717241wrq.10
        for <linux-efi@vger.kernel.org>; Fri, 04 Jun 2021 02:41:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vInzNIEC7qJ5S09yd5rz53tVm0jzaytwZERB+pVm5Bo=;
        b=J+oOleO9B5sqpAPjvJ+ijd0cSuuMRPUXKATEhAlymhd+GjibVggtfXGW9o6iDP+ICJ
         G17pyUXMXOC/jzs/9gOToaeaIk85DZmfXg20Iq5ul6URxZFsXw+AFiE7e/33FvXpeSXG
         +AiDlrM712X8TjnPyAdL7ECi/JnnY39Iv5QlvOBZDWyvi3t8jDU/x8CgBjbGKCG0VTB4
         Q8Gbsoy4i6//SywWYZk8hjx6O7yOPtUD1WizZgXJBA8vSZwNREYlq5Ixzu+/sYnsBTif
         H4sJOIm1l93sEc3zoic7JeifdbFHUCwMeYn9y+dg1gITNjksiantGzkDoVUgWVvTFag0
         E33Q==
X-Gm-Message-State: AOAM530PLm/9t4WSIiPunE3N+9EoQ3qZ/7YaHKJ3c4w6/TOKk3fOMpxL
        /Av1d53GcUBy//HS6nb6QXYD654iW6xvgdbGwOw23/25x17Z1mOCezYAU3aV22BvB96e9h5n6sJ
        16yBW/w23zSiMLXRwbWkF
X-Received: by 2002:a5d:4b05:: with SMTP id v5mr2924865wrq.330.1622799692504;
        Fri, 04 Jun 2021 02:41:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhdTfU1nuBk4nI718hAXg7aCCY0AbwUXs0SHoQeG2N7oNmbQ2psiZjVGvncyM/3mEKj6kYbw==
X-Received: by 2002:a5d:4b05:: with SMTP id v5mr2924840wrq.330.1622799692240;
        Fri, 04 Jun 2021 02:41:32 -0700 (PDT)
Received: from [192.168.1.101] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id u16sm6643628wru.56.2021.06.04.02.41.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 02:41:31 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] allow simple{fb,drm} drivers to be used on non-x86
 EFI platforms
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chester Lin <clin@suse.com>, Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        John Stultz <john.stultz@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org
References: <20210601145912.774054-1-javierm@redhat.com>
 <YLk7HjX2OnLhMt4V@zn.tnic>
From:   Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <c48c6261-c9e5-29cd-8d43-6dbbcb2034ff@redhat.com>
Date:   Fri, 4 Jun 2021 11:41:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YLk7HjX2OnLhMt4V@zn.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Borislav,

On 6/3/21 10:27 PM, Borislav Petkov wrote:
> On Tue, Jun 01, 2021 at 04:59:10PM +0200, Javier Martinez Canillas wrote:
>> The series touches different subystems and will need coordination between
>> maintainers. Ard Biesheuvel said that can be merged through the EFI tree.
> 
> I'm always happy when code from arch/x86/ moves away so
> 
> Acked-by: Borislav Petkov <bp@suse.de>
> 

Thanks for the ack.

> Btw, for the future, please CC everyone on the whole patchset - I had to
> go look at your 2/2 on lore to see what it does because I had only 1/2
> in my mbox.
> 

Yes, sorry about that. I just used what get_maintainer.pl --git-fallback
suggested me, I'll make sure to include all people in Cc the next time.

> Thx.
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer
New Platform Technologies Enablement team
RHEL Engineering

