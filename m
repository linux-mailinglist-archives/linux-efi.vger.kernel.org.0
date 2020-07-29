Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5158B232523
	for <lists+linux-efi@lfdr.de>; Wed, 29 Jul 2020 21:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgG2TNQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 29 Jul 2020 15:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgG2TNP (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 29 Jul 2020 15:13:15 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC23C0619D7
        for <linux-efi@vger.kernel.org>; Wed, 29 Jul 2020 12:13:15 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k18so6228633pfp.7
        for <linux-efi@vger.kernel.org>; Wed, 29 Jul 2020 12:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qGFRcRgcR931cJAUtagqOosR/FnU7E14dUW/H6LUoV0=;
        b=LojD0VehSq43MKm3UY2ptAJKk1Fg+Dz890OJAqBxww80QsP0ZXG0+NsI3rnP3MRS80
         gcs7DulgfW5Xl39kdQCI3ZvqNfNq/6oU5h1k4Pn4y8/j/4zZzrI0lVIUUJQG4UXyxn0t
         gt1XYvCjNMWuFltFntSdXqB5KY+Pk8nOPPRdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qGFRcRgcR931cJAUtagqOosR/FnU7E14dUW/H6LUoV0=;
        b=Wsq+GebnBJSoQQEsWF7IQbV3Pwb7FcZnZyo9qNLZV0MW54BtMCfti/JmMcWzA+FnvP
         1FL7cyXWeAW+vuRW7mWmUk96Uh95YXydoMYF5kxdqebWf6R7m7wVXlsBxpS9gV2DZHae
         xhRGFIg4ZwoTQCvBe/cEcQjh5ISHV+pqfGZ6lP6Ula8Pj+8GUxPrkYK8h5ZdHDfZEXZw
         eCQfHM0LDeoG7IDecSQLi6EkKW/2h54S3e00JibrDyQV/FbtS74zqMhPS5JgNq3PkDDg
         XEA3rEaeAcKBiAYkqORzs94pwEJYkJwUX2HALAXScZImyCFobbIBzlovq0YJ4iFugCHA
         R7bg==
X-Gm-Message-State: AOAM530SUaDLFg/RNCpKHcAxEJZUgJ0o9v1bDwuNt3fZxwNK44NCEqW2
        mVQomAP569szXTZ/EWNRt00Skg==
X-Google-Smtp-Source: ABdhPJwm3az6fUsmpW7/xrdfcyj4XHND2YQG4viZO33agdGtUSFkCSCWvvsJEvQgoeB/2eV7qKkUlA==
X-Received: by 2002:a63:4450:: with SMTP id t16mr7500213pgk.3.1596049994849;
        Wed, 29 Jul 2020 12:13:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 4sm3113116pgk.68.2020.07.29.12.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 12:13:13 -0700 (PDT)
Date:   Wed, 29 Jul 2020 12:13:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Jessica Yu <jeyu@kernel.org>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/19] firmware_loader: Use security_post_load_data()
Message-ID: <202007291205.CA09294424@keescook>
References: <20200724213640.389191-1-keescook@chromium.org>
 <20200724213640.389191-13-keescook@chromium.org>
 <1595847465.4841.63.camel@kernel.org>
 <202007281242.B6016AE4B@keescook>
 <e5ed8876b9907315c2a906ab248639ea8c6d2cd5.camel@linux.ibm.com>
 <e6f7ce4aa506ff016dde9a75c607849587c1ca2c.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6f7ce4aa506ff016dde9a75c607849587c1ca2c.camel@linux.ibm.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jul 29, 2020 at 02:10:18PM -0400, Mimi Zohar wrote:
> Actually, the partial firmware read should be calling
> security_kernel_read_file().

Yup, it does[1], and when "whole_file" is true, it will call
security_kernel_post_read_file() with the buffer contents at the end.

> The sysfs firmware fallback is calling security_kernel_load_data().

Correct[2]; it has no file associated with it (same as the EFI platform
source).

> Which firmware is calling security_kernel_post_load_data()?

sysfs and platform both call it[2], matched with their
security_kernel_load_data() calls.

-Kees


[1] v4 patch 14: "fs/kernel_file_read: Add "offset" arg for partial reads"
    https://lore.kernel.org/lkml/20200729175845.1745471-1-keescook@chromium.org/T/#iZ2e.:..:20200729175845.1745471-15-keescook::40chromium.org:0fs:kernel_read_file.c
[2] v4 patch 10: "firmware_loader: Use security_post_load_data()"
    https://lore.kernel.org/lkml/20200729175845.1745471-1-keescook@chromium.org/T/#iZ2e.:..:20200729175845.1745471-11-keescook::40chromium.org:0drivers:base:firmware_loader:fallback.c

-- 
Kees Cook
