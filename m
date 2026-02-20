Return-Path: <linux-efi+bounces-6192-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDmGArwcmGnp/wIAu9opvQ
	(envelope-from <linux-efi+bounces-6192-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 20 Feb 2026 09:35:08 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9F4165B3A
	for <lists+linux-efi@lfdr.de>; Fri, 20 Feb 2026 09:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FCD23049247
	for <lists+linux-efi@lfdr.de>; Fri, 20 Feb 2026 08:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545E1314B73;
	Fri, 20 Feb 2026 08:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aPwL1llw"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9CD30F549;
	Fri, 20 Feb 2026 08:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771576245; cv=none; b=QKklWGJYIz7MDsysjtGvxPRcO2ZipjSrYlCmc36zNtI487V+w9V+gSKTVD5ImgQYIevbbixTXnxR0c3GBcMlwbEeHZZkZamrVMzB/uT96pY/1X5sK4vKY5Lj5Xu6jX2rNclumaNqpREo3leLrMOYCdHKaA0Q0JBD41nfVZ/3JNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771576245; c=relaxed/simple;
	bh=OOkNKzJWZ2PKiWVeYu871t9knsMGA4JMCfqoaCA5Qc0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Wf2JvZosiPJ7llNITqDCgxir+oU0qA0THzrfo4HvP0tNxxW9Wbo4MYxf5Owi5izvuLrgzjpIHLX9huBZGrfB7YcKdHdw+4snIcptYC/ckWZAdr3fWJoaucAE9uy0d/1eh5toBnp9GKXPiEFLbF1PT9sPAma4hOEHFC+ElEIb8YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aPwL1llw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6916BC116D0;
	Fri, 20 Feb 2026 08:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771576244;
	bh=OOkNKzJWZ2PKiWVeYu871t9knsMGA4JMCfqoaCA5Qc0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=aPwL1llwYZ0PhJbYJjiccMMsFKNTpSN3h6HKEogc0SQMz0qNQ95k7ksQcMyHLRjzK
	 V60/YPqUhDW73lmKblFgu8a0slvOz89MYLjGDR+YttCGKKNianvSxnuMy9ax4BfD14
	 lZU0a4EmplrZP3FXNHbo6CJoWZS4W9XjwvCLq4/ylA8nJQ0Lulhq0hN7rX3Gx52dEn
	 36cwfpbnut6G1KNsmrkILyKkomEwq3EsuUQ6xL4TCJYqfZhZ8qmk0A48pXktKFzez/
	 RDCSP8cYbJqnbb50y21F212txXq/CGSZ2GdpPOCoOov13wP8rjvPAnbGqej0BOJA5Y
	 3J8X2mNNwPAMg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id EF254F40069;
	Fri, 20 Feb 2026 03:30:41 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Fri, 20 Feb 2026 03:30:42 -0500
X-ME-Sender: <xms:sRuYaZtdO-kEDZ6jyrUg29QVVJFQrny0pZ3ezNCYPVygXUo8kPT68Q>
    <xme:sRuYadTw0jR6o4mFsXaOb3AWdfxTdgAv1HFsKo5j_w9sORkvJLEhzV-q3spNFynOh
    2Ubtqz0ZMXu-WayYa5VUA01TJLh6XvD099OkNR3ywFqD-joIDr8dsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeeuteeiudeigeekjedvheduieehteetgfdtuefghfejgffhfedtleehvdeh
    fffhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeefvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepnhhivhgvughithgrsegrlh
    humhdrmhhithdrvgguuhdprhgtphhtthhopehluhhtohesrghmrggtrghpihhtrghlrdhn
    vghtpdhrtghpthhtohepughpshhmihhthhesrghpvghrthhushhsohhluhhtihhonhhsrd
    gtohhmpdhrtghpthhtoheprghnughrvgifrdgtohhophgvrhefsegtihhtrhhigidrtgho
    mhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoh
    epphgvthgvrhhhuhgvfigvsehgmhigrdguvgdprhgtphhtthhopehhvghrsggvrhhtsehg
    ohhnughorhdrrghprghnrgdrohhrghdrrghupdhrtghpthhtohepthhrvghntghhsghooh
    htqdguvghvvghlsehgohhoghhlvghgrhhouhhpshdrtghomh
X-ME-Proxy: <xmx:sRuYaSE41zy-0gKhEDntCwr9EkMSTDAbWBC6gFogmaZORdtSCZazBg>
    <xmx:sRuYaQuD_PamJME6yIMQvHwc-vTB6378FCneQDrqKdQkZr2d7YsGNg>
    <xmx:sRuYaYKiRTSt0NGzQEf8b1tar7A2Ez8t7wct0zTn-wFVaEhdpoQwBw>
    <xmx:sRuYafx_Sf8aIzNhbGWpWKYWTwuFMiqozbcCiCP20ySSLcMVutcyMg>
    <xmx:sRuYaT4yNHzt4j55xgiWueu0sefZ18usY5pqg8AA7-I87bnf8eokGbBA>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BE6FD700069; Fri, 20 Feb 2026 03:30:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAnEvm6syrbF
Date: Fri, 20 Feb 2026 09:30:21 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Andy Lutomirski" <luto@amacapital.net>
Cc: "Simo Sorce" <simo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 "Daniel P. Smith" <dpsmith@apertussolutions.com>,
 "Ross Philipson" <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev,
 dave.hansen@linux.intel.com, "Thomas Gleixner" <tglx@linutronix.de>,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, "Jarkko Sakkinen" <jarkko@kernel.org>, jgg@ziepe.ca,
 nivedita@alum.mit.edu, "Herbert Xu" <herbert@gondor.apana.org.au>,
 davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
 dwmw2@infradead.org, baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Message-Id: <9034c6a1-ebce-40b6-9ac8-0b8cc5a50dd4@app.fastmail.com>
In-Reply-To: 
 <CALCETrWynypSD7vEjJNLcym3JhBw4k0ovDiR_3YuOHh92TnM=A@mail.gmail.com>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com>
 <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
 <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com>
 <CALCETrUE8c-dxRWhtHKz_PojwZuWMXJSzOsFQf2vt5LS3ATwpA@mail.gmail.com>
 <1BBD7449-8420-43FD-930B-A4E1BA38FFC6@zytor.com>
 <CALCETrWzG1Mjb-RcwLQ5-tGFZ15WKHjZbqtLvyif+UPuVKJ_5g@mail.gmail.com>
 <32e62cef7b89d9691bdd4120388ce752fd041230.camel@redhat.com>
 <CALCETrUMR0RvOFXGzL7=F4c-3veL+1Sm2xf-BprHTK4=UKw8yA@mail.gmail.com>
 <558d0f28-01fb-4447-891c-2ffbf869c077@app.fastmail.com>
 <CALCETrWynypSD7vEjJNLcym3JhBw4k0ovDiR_3YuOHh92TnM=A@mail.gmail.com>
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-6192-lists,linux-efi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,zytor.com,apertussolutions.com,oracle.com,vger.kernel.org,kernel.org,lists.infradead.org,lists.linux.dev,linux.intel.com,linutronix.de,alien8.de,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,citrix.com,googlegroups.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amacapital.net:email];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9D9F4165B3A
X-Rspamd-Action: no action



On Thu, 19 Feb 2026, at 18:34, Andy Lutomirski wrote:
> On Wed, Feb 18, 2026 at 11:55=E2=80=AFPM Ard Biesheuvel <ardb@kernel.o=
rg> wrote:
>>
>> On Wed, 18 Feb 2026, at 22:54, Andy Lutomirski wrote:
>> > On Wed, Feb 18, 2026 at 1:04=E2=80=AFPM Simo Sorce <simo@redhat.com=
> wrote:
>> >>
>> >> On Wed, 2026-02-18 at 12:34 -0800, Andy Lutomirski wrote:
>> >> > On Wed, Feb 18, 2026 at 12:29=E2=80=AFPM H. Peter Anvin <hpa@zyt=
or.com> wrote:
>> >> > >
>> >> > > On February 18, 2026 12:03:27 PM PST, Andy Lutomirski <luto@am=
acapital.net> wrote:
>> >> > > > On Thu, Feb 12, 2026 at 12:40=E2=80=AFPM Ard Biesheuvel <ard=
b@kernel.org> wrote:
>> >> > > > >
>> >> > > > > On Thu, 12 Feb 2026, at 20:49, Daniel P. Smith wrote:
>> >> > > > > > On 2/9/26 09:04, Ard Biesheuvel wrote:
>> >> > > > > ...
>> >> > > > > But would it be better to disable the runtime services by =
default when doing a secure launch? PREEMPT_RT already does the same.
>> >> > > >
>> >> > > > So I have a possible way to disable EFI runtime service with=
out losing
>> >> > > > the ability to write EFI vars.  We come up with a simple fil=
e format
>> >> > > > to store deferred EFI var updates and we come up with a plac=
e to put
>> >> > > > it so that we find it early-ish in boot the next time around=
.  (This
>> >> > > > could be done via integration with systemd-boot or shim some=
 other
>> >> > > > boot loader or it could actually be part of the kernel.)  An=
d then,
>> >> > > > instead of writing variables directly, we write them to the =
deferred
>> >> > > > list and then update them on reboot (before TXT launch, etc)=
.  [0]
>> >> > > > This would be a distincly nontrivial project and would not w=
ork for
>> >> > > > all configurations.
>> >> > > >
>> >> > > > As a maybe less painful option, we could disable EFI runtime=
 services
>> >> > > > but have a root-writable thing in sysfs that (a) turns them =
back on
>> >> > > > but (b) first extends a PCR to say that they're turned back =
on.
>> >> > > >
>> >> > > > (Or someone could try running runtime services at CPL3...)
>> >> > > >
>> >> > > > [0] I have thought for years that Intel and AMD should do th=
is on
>> >> > > > their end, too.  Keep the sensitive part of SMI flash entire=
ly locked
>> >> > > > after boot and, instead of using magic SMM stuff to validate=
 that
>> >> > > > write attempts have the appropriate permissions and signatur=
es, queue
>> >> > > > them up as deferred upates and validate the signatures on th=
e next
>> >> > > > boot before locking flash.
>> >> > > >
>> >> > >
>> >> > > *If* a physical EFI partition exists there is a lot to be said=
 for this approach.
>> >> > >
>> >> > > The only issue with this that I can see is for things like net=
work or CD/DVD booting where there isn't necessarily any EFI boot partit=
ion, it might not be writable, or it might not be persistent (e.g. http =
booting typically uses a ramdisk, like the old Linux initrd.)
>> >> >
>> >> > Hmm, I guess my approach is a 100% complete nonstarter for insta=
lling
>> >> > Linux from a CD, and it's really not awesome for installing Linu=
x from
>> >> > a USB stick.
>> >>
>> >> Doing any of this on a removable device feels generally like a tra=
p.
>> >> You get your USB disk in, try to boot, and it saves vars, but rebo=
ot
>> >> fails for whatever reason, you plug it in another machine ... and =
it
>> >> tries to "continue" from there? The amount of validation needed and
>> >> testing for failure modes across reboots sounds really painful.
>> >
>> > I kind of stand by my other previous suggestion, though:
>> >
>> > As a maybe less painful option, we could disable EFI runtime servic=
es
>> > but have a root-writable thing in sysfs that (a) turns them back on
>> > but (b) first extends a PCR to say that they're turned back on.
>> >
>>
>> After setting the EFI boot path to GRUB (or systemd-boot or whatever)=
 at installation time, what other meaningful interactions do we expect w=
ith the EFI runtime services?
>>
>> And given that the secure launch is orchestrated by the bootloader , =
with which the kernel has a backchannel via its configuration file, it s=
hould be rather straight-forward to implement the staging of variable up=
dates there if we really need it.
>>
>> Doing any of this at the EFI/spec level might lead to a situation whe=
re the OS now has to guess which of the provided APIs to manipulate vari=
ables is the least broken.
>>
>> Of course, for readinf variables, dumping the RT variables into a mem=
ory buffer at boot time and exposing it via a EFI config table would be =
rather straight-forward, but it is also something I feel should be the j=
ob of the boot component that takes part in the decision to shield the r=
untime services from the OS.
>
> So there's sort of a usability issue here.  On the one hand, this can
> all be orchestrated to work.  We build a kernel, and the kernel
> supports secure launch.  Someone makes an installer image, and that
> image is configured to skip secure launch, then install to disk, then
> program EFI vars, then reboot.  And the installed image is configured
> to do the secure launch, and EFI variable writes are turned off.
>
> On the other hand, this all sucks.  I'm getting sick of having the
> kernel tell me that I am not permitted to do things.  I'm sick of
> writing software that deals with unnecessary restrictions.  If I were
> writing an OS with a USB stick-based installer, I might want to be
> able to boot the thing and decide later whether I'm installing an OS
> to disk.  (In fact, many USB installers work this way.)  But, in the
> model where EFI variable writes are hard-disabled on a secure launch,
> the decision to do the secure launch happens before the decision to
> install an OS, and we all lose.
>
> So I'm proposing that EFI variable writes be treated a bit like kexec
> [0] -- root (which is already part of the TCB for any practical
> purpose) is going to decide, like a grown up, to execute some code
> that it doesn't fully trust -- in this case, the EFI variable writes.
> And root will coordinate, correctly, with whomever it's busy using the
> TPM to coordinate with, and tell it that it's going to do something
> that will change its trustworthiness.  So it works like this:
>
> 1. Secure launch the environment on the stick.  (At this stage,
> neither the boot loader nor the kernel has the faintest clue whether
> anyone needs that secure launch, but this doesn't matter.)
>
> 2. The owner of the machine clicks "install".
>
> 3. The installer makes some partitions and writes some files.
>
> (Up until now, the security posture of the running environment has not=
 changed.)
>
> 4. The installer decides that it's now time to do untrustworthy
> things, namely writing EFI vars.  So it unmounts anything it mounted
> using TPM-sealed keys (or not -- this is between the distro and
> whoever trusts the distro), and it does:
>
> # echo 1 >/sys/.../extend_pcr_and_unlock_efi
>
> which *first* extends a PCR because we are about to change our
> security posture and *second* sets whatever flag permits use of EFI
> runtime services.
>
> 5. The installer writes to EFI variables.  And the installer can no
> longer generate attestations to its previous security posture, which
> is the correct behavior.  And maybe the user can no longer unlock
> their home directory or whatever until they reboot.  Which is not
> really a big deal.
>
> (This is *dynamic* root of trust.  In theory the system could do a
> DRTM re-launch and recover its security posture, but I don't think
> this is implemented.)
>
>
> One thing I like about this is that it involves very little code.
>

It does seem rather straight-forward, and it doesn't have to be specific=
 to TXT either. I.e., we should probably always measure the runtime enab=
led/disabled state into the PCRs.

But given the actual problem at hand (untrustworthy glue code running in=
 ring 3 that does little more than poke SMM, which itself fundamentally =
remains part of the TCB), it would be nice if we could just sandbox that=
 code using virtualization.

This came up in a separate discussion regarding ACPI PRM (the new dumpin=
g ground for evil vendor code now that SMM has gone out of fashion), alt=
hough there it should be feasible to run it unprivileged, as the spec re=
quires that capability for the PRM payloads.

