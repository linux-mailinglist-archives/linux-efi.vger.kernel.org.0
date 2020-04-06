Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47BB419F695
	for <lists+linux-efi@lfdr.de>; Mon,  6 Apr 2020 15:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgDFNOl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 6 Apr 2020 09:14:41 -0400
Received: from fallback25.m.smailru.net ([94.100.189.1]:46796 "EHLO
        fallback25.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728271AbgDFNOl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 6 Apr 2020 09:14:41 -0400
X-Greylist: delayed 2244 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Apr 2020 09:14:40 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=prok.pw; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=iiNfHbyZdz43eY/ca1ZTDKaSuSr+HPfVBFPF8k2SFn4=;
        b=bMzBCQCXt7YcOnWEiuhQXHkHpXme3hxQbJAlobZMGZw+aeYrz/mPui9HSIugXP8UadagmbMKI20AZj4XGVDFimnewZ39tt+ZDRgBm2X6gtof/SSdP5mVIAbFMew58FNAe/ZG76W7pVr8pFEQZezGgA66R/U58zR9BuHoi1BapQI=;
Received: from [10.161.76.76] (port=48690 helo=smtp17.mail.ru)
        by fallback25.m.smailru.net with esmtp (envelope-from <me@prok.pw>)
        id 1jLR05-0008OP-Un; Mon, 06 Apr 2020 15:37:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=prok.pw; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=iiNfHbyZdz43eY/ca1ZTDKaSuSr+HPfVBFPF8k2SFn4=;
        b=bMzBCQCXt7YcOnWEiuhQXHkHpXme3hxQbJAlobZMGZw+aeYrz/mPui9HSIugXP8UadagmbMKI20AZj4XGVDFimnewZ39tt+ZDRgBm2X6gtof/SSdP5mVIAbFMew58FNAe/ZG76W7pVr8pFEQZezGgA66R/U58zR9BuHoi1BapQI=;
Received: by smtp17.mail.ru with esmtpa (envelope-from <me@prok.pw>)
        id 1jLQzt-0000PQ-Fc; Mon, 06 Apr 2020 15:37:02 +0300
Message-ID: <a406bd0ab573e17c1004d3d91948938c209cf94d.camel@prok.pw>
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from
 bzImage
From:   Sergey Shatunov <me@prok.pw>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     bp@alien8.de, hpa@zytor.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-efi <linux-efi@vger.kernel.org>
Date:   Mon, 06 Apr 2020 19:36:57 +0700
In-Reply-To: <CAMj1kXHWhPmnaCS74n=1MYLfnsKqf+UAfmaLGQYx9jH3YsXvfg@mail.gmail.com>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
         <20200405154245.11972-1-me@prok.pw>
         <20200405231845.GA3095309@rani.riverdale.lan>
         <CAMj1kXHWhPmnaCS74n=1MYLfnsKqf+UAfmaLGQYx9jH3YsXvfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-7564579A: 78E4E2B564C1792B
X-77F55803: 0A44E481635329DB0E1AA8A03B392317D32E5E48865217365060145B739F5F5C7141CD936E95A8CDF688BCB05C26794D00EEFFA3BE1FE4186B5281BCEF864E538028E4E492F5D27DF3F88509D94693E6
X-7FA49CB5: 0D63561A33F958A580C73DA523369336E96807BD70808086B9B34D7F4F05369A8941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F446042972877693876707352033AC447995A7AD18CB629EEF1311BF91D2E47CDBA5A965834E70A05D1297E1BBBA3038C0950A5D3613377AFFFEAFD269176DF2183F8FC7C0207D9C0C136568F07B076A6E789B0E97A8DF7F3B2552694A0E14360347543F5849FD398EE364050F140C956E756FBB7A287C8E22D4AE2A51B3661434B16C20AC446828A5085A663B75ECD9A6C639B01B78DA827A17800CE7F2C1598F50A6BE78731C566533BA786A40A5AABA2AD371193C9F3DD0FB1AF5EB82E77451A5C57BD33C9F3DD0FB1AF5EB4E70A05D1297E1BBCB5012B2E24CD356
X-D57D3AED: Y8kq8+OzVozcFQziTi/Zi1xwo7H2ZNxGP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSo0zU/dgAo80gyxHfUpwjuv
X-Mailru-Internal-Actual: A:0.8248366176939
X-Mailru-Sender: C70B145DBB19DC3370B3FB291950C1B52184C016B27618789BBACE8634A6DD1B21401CF93FD6FA558BA0E2A9D6159BD266FEC6BF5C9C28D9A91CF0FA91B32267255DC5169939796B8DAAFE1477B51D223453F38A29522196
X-Mras: Ok
X-7564579A: EEAE043A70213CC8
X-77F55803: 5241C2F38277A35D7F9F52485CB584D7271FD7DF62800FDC8349DAC01D6AC244C1DFF59873A986F96AE448ABDB49831B39120FE16160CBFC
X-7FA49CB5: 0D63561A33F958A5445C049CA4483CE68A021D6C2AED2A5D3398B9421A0FB76A8941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F446042972877693876707352033AC447995A7AD18CB629EEF1311BF91D2E47CDBA5A965834E70A05D1297E1BBBA3038C0950A5D3613377AFFFEAFD269176DF2183F8FC7C0207D9C0C136568F07B076A6E789B0E97A8DF7F3B2552694A0E14360347543F5849FD398EE364050F140C956E756FBB7A287C8E22D4AE2A51B3661434B16C20AC446828A5085A663B75ECD9A6C639B01B78DA827A17800CE7F2C1598F50A6BE78731C566533BA786A40A5AABA2AD371193C9F3DD0FB1AF5EB82E77451A5C57BD33C9F3DD0FB1AF5EB4E70A05D1297E1BBCB5012B2E24CD356
X-D57D3AED: Y8kq8+OzVozcFQziTi/Zi1xwo7H2ZNxGP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSpZAwB8bZ7p2bRFuIOw5Q1i
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C9005B3CA2E2FD44993EC0BAA86055D9A8C08C1DFF59873A986F95F9045B74F665CC88BA0E2A9D6159BD266FEC6BF5C9C28D9A91CF0FA91B32267255DC5169939796B8DAAFE1477B51D223453F38A29522196
X-Mras: Ok
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2020-04-06 at 10:44 +0200, Ard Biesheuvel wrote:
> On Mon, 6 Apr 2020 at 01:18, Arvind Sankar <nivedita@alum.mit.edu>
> wrote:
> > On Sun, Apr 05, 2020 at 10:42:46PM +0700, Sergey Shatunov wrote:
> > > This patch causes some strange things happens with my laptop.
> > > 
> > > Cold boot crashed in some early initilization logic with message
> > > 'Failed to execute /esp/.../linux.efi: Buffer Too Small'.
> > > After couple reboots into firmware setup (bios) or hot reboot
> > > from other working kernel (without that commit) helps it to boot.
> > > During bisecting couple times I saw different message:
> > > 'exit_efi() failed; efi_main() failed', but above tricks helps it
> > > too.
> 
> Could you please try adding 'efi=no_disable_early_pci_dma' to the
> kernel command line? The lack of BSS zeroization may result in that
> option to get inadvertently enabled, and it is known to break
> exit_boot() on some systems.

With 'efi=no_disable_early_pci_dma' it works again.

