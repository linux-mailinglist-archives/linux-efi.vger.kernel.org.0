Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13A7A194D9A
	for <lists+linux-efi@lfdr.de>; Fri, 27 Mar 2020 00:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgCZX4m (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Mar 2020 19:56:42 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34774 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCZX4m (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 26 Mar 2020 19:56:42 -0400
Received: by mail-qk1-f193.google.com with SMTP id i6so9135386qke.1;
        Thu, 26 Mar 2020 16:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sD9cv/e/jx5JHSt1rnho9FXARIJYPMfW1ypvOFyaY9s=;
        b=N+e3K4TvDyaZ4Dj3m/utvfySSSdAIElHH8I6frjCUQ8/IE6J328+51GyH8jujFQut4
         HAff1kN88iXqRe/wHMTy+l4o22hXNQqDzbO/92qbXZ7Szd+fbSHwmsmsYcGz42WqS/Mf
         xV52WnXtW6O9A5DNp+5GLNYaN5YQ8kZ8qnVrtkhLwEjKpztozDYgIbSJTTfJGVeFOUHf
         DKiAmoypGikmU0z0PMzshLhfGGGrj3sSXvxiSK8uYMSbLE2QP3PCPtGp8riE45C+2bsN
         RlPMoMAxAvvOBt/+Pzds1dgnRJyy2qTle/1siuV4vl1Gd7GcmkIAOBDeNKpvnvPJuBnG
         HvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sD9cv/e/jx5JHSt1rnho9FXARIJYPMfW1ypvOFyaY9s=;
        b=lMu5Jnia1rYV2a90CDPeUteuZ4H5CS8Zbh7DohU9eGS76BE7pRHxPWGNrouG5BfBrx
         /s3ln9SpGOoaRYknZDYQXzyncGsdgFxwZIqMJbnSJjyMgcOtqogl1ooNkz9zgcCNidql
         xR28tfk+yzEQgu6lfXVUk48rbhtEqMygM5Ty7/PMt3MY5S8dGkxjYFLHliT/1NpbtClM
         gjk86f6eF/LFxy8t/xSwcJyIqVLwFRYgH83xa1xitpfJzLcRdeb0+GBx75aiNsuBtcKL
         wt2E2FYUWYLCCpAnkhuWzMbK7zGjI6wD+8RwEzeOyveeRx0YGAch7OjxUsIB/lfCGRoB
         sxsQ==
X-Gm-Message-State: ANhLgQ18mIV5N5vwPMgKxlKZ28wrm1FWTOXk8h6OWKsdbobJD2om5NdE
        SGnKcYgUtOi+EiyPeX7BZPw=
X-Google-Smtp-Source: ADFU+vtbe3D/qiE2OVFodOIkccs0SBYWk0CMSYd6+UEbXddisShf9BqeySwyFWPU/wSD3O9cpYT0VQ==
X-Received: by 2002:a05:620a:22b1:: with SMTP id p17mr11774955qkh.396.1585267000525;
        Thu, 26 Mar 2020 16:56:40 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p1sm2524807qkf.73.2020.03.26.16.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 16:56:40 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 26 Mar 2020 19:56:38 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/14] efi/gop: Refactoring + mode-setting feature
Message-ID: <20200326235637.GA2364023@rani.riverdale.lan>
References: <20200319192855.29876-1-nivedita@alum.mit.edu>
 <20200320020028.1936003-1-nivedita@alum.mit.edu>
 <CAKv+Gu8-iK-FQrgCY6YGXyg155chMPJQZeQr-i_xQbqoQ57F0g@mail.gmail.com>
 <20200325221007.GA290267@rani.riverdale.lan>
 <CAMj1kXHPmtYgoUViF4baVHfy178ef8u57wJgqcZVagGTAuP3iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXHPmtYgoUViF4baVHfy178ef8u57wJgqcZVagGTAuP3iQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Mar 26, 2020 at 12:36:25AM +0100, Ard Biesheuvel wrote:
> 
> Yes, -ffreestanding implies -fno-builtin, which means that the
> compiler cannot assume it knows (and can optimize away) the behavior
> of strlen(), memset(), etc.

Yes exactly. Do you foresee any problems with removing it?

Thanks.
