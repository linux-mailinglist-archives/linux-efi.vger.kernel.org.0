Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB2C179859
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 19:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbgCDSsJ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 13:48:09 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45660 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbgCDSsI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Mar 2020 13:48:08 -0500
Received: by mail-qk1-f196.google.com with SMTP id z12so2675412qkg.12;
        Wed, 04 Mar 2020 10:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NE5tobHQQ2/3ErluiyeeeZc0smcvyLLr1pL5i5navJs=;
        b=vgLyJXOZMYFDxEDTurLuSy02/JBbnhPP3GdGoQvQ6RqU0ZHMg+8P9f4HAowXJVsydN
         Q9sGvGFIvUWQfv4RcYMSmemJiHBcVjWbmy1xaIN/TsRAIUPvWHMAWAyPBL0FypeEKeE0
         HrGOetNNySYDAOIA5hrarBVoSvHx6QvM6nSjW/W+uhsRmRWymmmahAZIkexD1pkYMLpv
         OWDW8wOFdbyWTDlKHU02wDL5Dz0LUCd5LhADqcJa0+Eb7VS0bop3i+uqLszWWJNrNowO
         IXloVTfneCihFhuvnNa3BbAU2LPPQ1C7vEDiyP2dsmS3nYAlRSrq63f/9nulE2q+Yd3Z
         oGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NE5tobHQQ2/3ErluiyeeeZc0smcvyLLr1pL5i5navJs=;
        b=GiL5bUxjQyH+znMXZU/d61QtiZzJWhx8QiD0gogy0ZAwEVivlW2WkWICF/CSoVTddg
         7awxigqrkLg5b5HePhdpQSKm8FJN/+bh+NU1of9PPr8DY9J87JkCCWa83wCh1mZTOOna
         pHQ/0hAvLfkb6LnMQGlHlkIu4tQFWxWm3jLEzWOJfgkhuZq9XDqwOFaZL3JbB4gjXv/9
         k56PA2GH5KtLCQ5AkwihCZAkXPYWjy36ly317FiEHj+6FR9gKx5jE9ZkN1BcHd+yF16L
         0ivK+bYfH/yVrSzLuj94JCkLzdaun2kb1o2xPr8/S8YULSQI0WBgmmbZCG7hYNgVZh37
         D7KQ==
X-Gm-Message-State: ANhLgQ2oQUcki7oBAZ+Sa8FbFYoGdH2lDhC+pE2H7W6MJjQJDEAWV5Uy
        wZOT4pIB3w1oEHq+IiTM0ZM=
X-Google-Smtp-Source: ADFU+vuH4bJG0CwNuNhdTWeMa+5zAxWQkTX0eTiU/hoMSeXX9hvN4i3hPiQx+etl4r9fKWvStXAGCg==
X-Received: by 2002:a37:688f:: with SMTP id d137mr4225697qkc.54.1583347686447;
        Wed, 04 Mar 2020 10:48:06 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v21sm11821508qto.97.2020.03.04.10.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 10:48:06 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 4 Mar 2020 13:48:04 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] efi/x86: Move mixed-mode thunk to efi/libstub
Message-ID: <20200304184804.GA263581@rani.riverdale.lan>
References: <20200304183659.257828-1-nivedita@alum.mit.edu>
 <CAKv+Gu_Bc5WYG_D7cM_fPi8rV65ouEre8uYUck0FCxN9FSUopw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_Bc5WYG_D7cM_fPi8rV65ouEre8uYUck0FCxN9FSUopw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Mar 04, 2020 at 07:39:23PM +0100, Ard Biesheuvel wrote:
> On Wed, 4 Mar 2020 at 19:37, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > Commit c2d0b470154c ("efi/libstub/x86: Incorporate eboot.c into
> > libstub") moved all the callers of the mixed-mode thunk into
> > efi/libstub, so move the thunk itself as well for completeness.
> >
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> 
> Thanks for the patch, but I'd prefer to leave the .S pieces under arch/
> (unless there's some benefit I'm not seeing)
> 

Ok. I can't think of any objective benefit.
