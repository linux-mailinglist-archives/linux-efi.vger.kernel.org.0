Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05106F828A
	for <lists+linux-efi@lfdr.de>; Mon, 11 Nov 2019 22:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfKKVqg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Nov 2019 16:46:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34345 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbfKKVqf (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Nov 2019 16:46:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id e6so16359081wrw.1
        for <linux-efi@vger.kernel.org>; Mon, 11 Nov 2019 13:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z19yH60lspQOQpX3PTFyVmzAHxSqcnfoBNNeK2r9yWE=;
        b=nV9YueSXoouxRoL8YbLIG6XT1i0a1/U8WGkeiWjPghCqzPViufj340DHozYi0mJczB
         VVV2PQNUz0Dg90lCv+jwwp+e2Bmd302kQks0HKNJfZ6l5tpK8BTpHQihkxSoWK7dEJ1/
         +Ssafs7zqNVAr1NWYgXjzP2m9Sg4KU3RQfnr2tcMEVT1uS+lczdaJ0hX4MVEEhlYjOOL
         QejyLY/ZmiZ2viNLxGFE4IVYC75HAOdEx5kXt9fXbzk/hCHbzbiPTPe68YJ4BbjBFOCB
         xxDhUBoM+hRBURFVYdfbAG7XRJ2qcpGdiwYCEPy/3DEb53REXjBuIC92Usxuut3asvOx
         SNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z19yH60lspQOQpX3PTFyVmzAHxSqcnfoBNNeK2r9yWE=;
        b=qqBY0CnRz6l3o+Memzm18zj56tcsuMS7Co2Hiti58udILgbVhLTvN8g5tWbeLBk+eu
         GAbhQtApYBXMC7pWO7fakqI9nF+I97RVe2TbwcWUN+Em4hMhM1u7Gq39r+uRMbYjWJkD
         IpRao3Kyv4IGjgJWDftO6WdpDivsZvAi+eEMTxh2AOKSiyJP5av81XUkwbNP+JJRK2Fi
         K++O0Bp9zWA5F/F1cygM0Yla2u+lNRdpQXIAWCpXFrmPZ77olFEiUmu4xKrB2AMhXam2
         7DAfTc7hMHOFjDM2Yn16rto7W9wfEYXwLHftNGSkse1oBsNoDSEqohlxJRB/yDKqzmgH
         FiVg==
X-Gm-Message-State: APjAAAXS9rJlf2ElFxxZzVGWNLXKMq3Rz5lQaHFXQEvQ09SFWhmWFa2W
        x8sr5sHw7gAYarsGXQRD+eI33Li5fkZ8Mg+i4+7mnA==
X-Google-Smtp-Source: APXvYqyCjdvPpxGWoMEuQTI+xfip9kJqo3D8X4t/W8OSXRPRKCrjLVbKRW/MMnI9aw+asqs97MeXAfxKoRUIZ+BG8I8=
X-Received: by 2002:adf:ec42:: with SMTP id w2mr21288389wrn.32.1573508794043;
 Mon, 11 Nov 2019 13:46:34 -0800 (PST)
MIME-Version: 1.0
References: <ac8c3a1d-e44a-4f89-8a58-fb3ef09659d4@gmail.com>
In-Reply-To: <ac8c3a1d-e44a-4f89-8a58-fb3ef09659d4@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 11 Nov 2019 21:46:22 +0000
Message-ID: <CAKv+Gu-cPmnxtN_5Y_=kodF7KcKjK+vkPdd+9gDiR55Mh4CKhg@mail.gmail.com>
Subject: Re: Linux 5.3.8: gsmi: failed to allocate name buffer. BUG: kernel
 NULL pointer dereference
To:     Kyle K <kylek389@gmail.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 11 Nov 2019 at 19:05, Kyle K <kylek389@gmail.com> wrote:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=205445
>
> Someone please take a look at this. There's is a regression in Linux
> 5.3.8 related to google EFI code changes that is causing sideeffects on
> Coreboot enabled laptops resulting in inability to suspend/wakeup and
> WiFi troubles. There's is another person experiencing same issue when
> upgrading to 5.3.8, so this bug is pretty much confirmed.
>

Someone please bisect this on the affected hardware.
