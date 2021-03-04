Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABE132CE7E
	for <lists+linux-efi@lfdr.de>; Thu,  4 Mar 2021 09:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235789AbhCDIay (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Mar 2021 03:30:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:51918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236778AbhCDIaw (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 4 Mar 2021 03:30:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 089CD64F07;
        Thu,  4 Mar 2021 08:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614846612;
        bh=p+LFYEJoTZPD5guFNbCgjfsD5MOV4lQEg1/noCdx6g0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aqbhMAJqfzqZVNTk+HxCq0YEvH0DlWywVMMT/vsKEPxai5Qtx1O+yKb2Ksqh7dQKG
         6AD7bDyRoGLMbuJCHL7uaQ5HgWT+d1aLTr9ZlQt1D4xG8XzjwlifHkll8KNnKy9rsX
         qi4pjB7WF6HR4m6pQZA3UxngjOZ/q5LtCGfqg4dOgD4K9j62aNAJHk9R8DkHWmSRX0
         zx9xfelM+0ZSkreqNUN8HmUoCoACjFg6Ce0bLEjJA7/6r6JEihanJag0QOpWKsH0yU
         LO2HMTF+hCfaHxIqIiUXHRNpMYNk3KpYaUWgPk4jz/pHqDo2Ypfkgo37omLL0Agl/K
         xVaQ8q8ktMNnQ==
Received: by mail-ot1-f47.google.com with SMTP id h10so15809737otm.1;
        Thu, 04 Mar 2021 00:30:11 -0800 (PST)
X-Gm-Message-State: AOAM530qgVfIVCXiABhjdGdPmrH+UEoJ1K1YJBrcryEesfTdgecV3usG
        Lbe4eZtqp7HFJA6xeJDtkfveeT/e0AB0AcO3ufY=
X-Google-Smtp-Source: ABdhPJxYBMJoudqekui521vRf42I2gPjyAMXoSs0/ZyckrKw0z9xkv8aYatVKNS2gMQxPwrCckGCNDLcWKAwPEzBhXw=
X-Received: by 2002:a9d:7512:: with SMTP id r18mr2646719otk.90.1614846611398;
 Thu, 04 Mar 2021 00:30:11 -0800 (PST)
MIME-Version: 1.0
References: <20210304082837.22262-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20210304082837.22262-1-heikki.krogerus@linux.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 4 Mar 2021 09:30:00 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHXOGidWqueyxmxSQOQ6+1DW4trTg600roLF20Zh0_Z2g@mail.gmail.com>
Message-ID: <CAMj1kXHXOGidWqueyxmxSQOQ6+1DW4trTg600roLF20Zh0_Z2g@mail.gmail.com>
Subject: Re: [PATCH] efi/apple-properties: Handle device properties with
 software node API
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

(+ Lukas)

On Thu, 4 Mar 2021 at 09:28, Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> The old device property API is going to be removed.
> Replacing the device_add_properties() call with the software
> node API equivalent, device_create_managed_software_node().
>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/firmware/efi/apple-properties.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/apple-properties.c b/drivers/firmware/efi/apple-properties.c
> index e1926483ae2fd..4c3201e290e29 100644
> --- a/drivers/firmware/efi/apple-properties.c
> +++ b/drivers/firmware/efi/apple-properties.c
> @@ -157,7 +157,7 @@ static int __init unmarshal_devices(struct properties_header *properties)
>                 if (!entry[0].name)
>                         goto skip_device;
>
> -               ret = device_add_properties(dev, entry); /* makes deep copy */
> +               ret = device_create_managed_software_node(dev, entry, NULL);
>                 if (ret)
>                         dev_err(dev, "error %d assigning properties\n", ret);
>
> --
> 2.30.1
>
